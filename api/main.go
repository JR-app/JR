package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"

	"github.com/JR-app/JR/api/secrets"
	"github.com/JR-app/JR/api/vars"
	"github.com/golang-jwt/jwt/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

func getRoot(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("got / request\n")
	io.WriteString(w, "root address\n")
}

func getHello(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("got /hello request\n")
	io.WriteString(w, "Hello World!\n")
}

func githubAuthHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("got /api/githubauth request\n")

	type AuthToken struct {
		Token string `json:"token"`
	}

	var authToken AuthToken

	var decoder = json.NewDecoder(r.Body)
	err := decoder.Decode(&authToken)
	if err != nil {
		fmt.Printf("githubAuthHandler json decode error\n")
		w.WriteHeader(http.StatusBadRequest)
	}
	fmt.Printf("DEBUG CODE: %v\n", authToken.Token)
	type TokenExchange struct {
		ClientId     string `json:"client_id"`
		ClientSecret string `json:"client_secret"`
		Code         string `json:"code"`
		RedirectURI  string `json:"redirect_uri"`
	}
	tokenExchange := TokenExchange{vars.GITHUB_OAUTH_CLIENT_ID, secrets.GITHUB_OAUTH_CLIENT_SECRET, authToken.Token, vars.GITHUB_OAUTH_REDIRECT}
	jsonBytes, err := json.Marshal(tokenExchange)
	if err != nil {
		fmt.Printf("githubAuthHandler json marshal broken\n")
	}

	req, err := http.NewRequest("POST", "https://github.com/login/oauth/access_token", bytes.NewBuffer(jsonBytes))
	if err != nil {
		fmt.Printf("token exchange broken\n")
	}
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")
	fmt.Printf("REQUEST:\n %v\n", req)

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		fmt.Printf("error in github token exchange POST request\n")
	}

	type TokenRecieved struct {
		AccessToken string `json:"access_token"`
		Scope       string `json:"scope"`
		TokenType   string `json:"token_type"`
	}

	var tokenRecieved TokenRecieved
	recievedTokenDecoder := json.NewDecoder(resp.Body)
	recievedTokenDecoder.Decode(&tokenRecieved)
	if err != nil {
		fmt.Printf("error in reading github token exchange POST request\n")
	}

	fmt.Printf("RESPONSE!!!\n%v\n", tokenRecieved)

}

func main() {
	jrapiascii := `
    ___  ________          ________  ________  ___     
   |\  \|\   __  \        |\   __  \|\   __  \|\  \    
   \ \  \ \  \|\  \       \ \  \|\  \ \  \|\  \ \  \   
 __ \ \  \ \   _  _\       \ \   __  \ \   ____\ \  \  
|\  \\_\  \ \  \\  \|       \ \  \ \  \ \  \___|\ \  \ 
\ \________\ \__\\ _\        \ \__\ \__\ \__\    \ \__\
 \|________|\|__|\|__|        \|__|\|__|\|__|     \|__|
                                                       
                                                       
                                                       

`
	fmt.Printf("%v", jrapiascii)
	http.HandleFunc("/", getRoot)
	http.HandleFunc("/hello", getHello)
	http.HandleFunc("/api/githubauth", githubAuthHandler)

	err := http.ListenAndServe(":3333", nil)
	if errors.Is(err, http.ErrServerClosed) {
		fmt.Printf("ERROR: server closed\n")
	} else if err != nil {
		fmt.Printf("ERROR: server start error")
		os.Exit(1)
	}
}
