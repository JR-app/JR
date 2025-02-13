import { useEffect } from 'react';
import * as WebBrowser from 'expo-web-browser';
import { makeRedirectUri, useAuthRequest } from 'expo-auth-session';
import { Button } from 'react-native';


WebBrowser.maybeCompleteAuthSession();


// Endpoint
const discovery = {
  authorizationEndpoint: 'https://github.com/login/oauth/authorize',
  tokenEndpoint: 'https://github.com/login/oauth/access_token',
  revocationEndpoint: 'https://github.com/settings/connections/applications/Ov23lix02SgcPGceGh58',
};

export default function GithubAuthButton() {
  const [request, response, promptAsync] = useAuthRequest(
    {
      clientId: 'Ov23lix02SgcPGceGh58',
      scopes: ['identity'],
      redirectUri: makeRedirectUri({
        scheme: 'your.app'
      }),
    },
    discovery
  );

  useEffect(() => {
    if (response?.type === 'success') {
      const { code } = response.params;
      console.log("code:")
      console.log(code);

      fetch("http://localhost:3333/api/githubauth", {
        method: "POST",
        body: JSON.stringify({
          "token": code
        }),
        headers: {
          "Content-type": "application/json"
        }
      }).then((r) => r.json())
        .then((json) => console.log(json));
    }
  }, [response]);

  return (
    <Button
      disabled={!request}
      title="Login With Github"
      onPress={() => {
        promptAsync();
      }}
    />
  );
}
