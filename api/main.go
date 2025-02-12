package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
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
	type AuthToken struct {
		Token	string	`json:"token"`
	}

	var authToken AuthToken

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&authToken)
	if err != nil {
		fmt.Printf("githubAuthHandler json decode error\n")
		w.WriteHeader(http.StatusBadRequest)
	}
	fmt.Printf("%v", authToken.Token)
	type TokenExchange struct {
		ClientId 			string	`json:"client_id"`
		ClientSecret 	string	`json:"client_secret"`
		Code 					string	`json:"code"`
		RedirectURI 	string	`json:"redirect_uri"`
	}
	tokenExchange := TokenExchange{os.Getenv("GITHUB_OAUTH_CLIENT_ID"), os.Getenv("GITHUB_OAUTH_CLIENT_SECRET"), authToken.Token, "exp://tln-tss-anonymous-8081.exp.direct"}
	jsonBytes, err := json.Marshal(tokenExchange)
	if err != nil {
		fmt.Printf("githubAuthHandler json marshal broken\n")
	}

	resp, err := http.Post("https://github.com/login/oauth/access_token", "application/json", bytes.NewBuffer(jsonBytes))
	if err != nil {
		fmt.Printf("token exchange broken\n")
	}

	// TODO: handle response properly
	fmt.Printf("%v", resp)
}

func main() {
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
