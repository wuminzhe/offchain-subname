import { Controller } from "@hotwired/stimulus"
import React, { useState } from 'react';
import { createRoot } from 'react-dom/client';

import {
  getDefaultConfig,
  RainbowKitProvider,
} from '@rainbow-me/rainbowkit';
import { WagmiProvider } from 'wagmi';
import {
  // darwinia,
  koi,
} from 'wagmi/chains';
import {
  QueryClientProvider,
  QueryClient,
} from "@tanstack/react-query";

import { ConnectButton } from '@rainbow-me/rainbowkit';
import { http } from 'wagmi';

// Authentication
import { createAuthenticationAdapter } from '@rainbow-me/rainbowkit';
import { SiweMessage } from 'siwe';
import { RainbowKitAuthenticationProvider } from '@rainbow-me/rainbowkit';
const authenticationAdapter = createAuthenticationAdapter({
  getNonce: async () => {
    const response = await fetch('/api/nonce');
    return await response.text();
  },

  createMessage: ({ nonce, address, chainId }) => {
    return new SiweMessage({
      domain: window.location.host,
      address,
      statement: 'Sign in with Ethereum to the app.',
      uri: window.location.origin,
      version: '1',
      chainId,
      nonce,
    });
  },

  getMessageBody: ({ message }) => {
    return message.prepareMessage();
  },

  verify: async ({ message, signature }) => {
    const verifyRes = await fetch('/api/verify', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ message, signature }),
    });

    console.log(verifyRes)
    console.log(verifyRes.ok)
    return Boolean(verifyRes.ok);
  },

  signOut: async () => {
    await fetch('/api/logout');
  },
});
// End Authentication

const config = getDefaultConfig({
  appName: 'My RainbowKit App',
  projectId: '873f70fa626990b1ee3c14d55130a573',
  chains: [koi],
  transports: {
    [koi.id]: http(),
  },
  ssr: false, // If your app uses SSR, set this to true
});

// Create a client
const queryClient = new QueryClient();

const YourApp = () => {
  return <ConnectButton accountStatus="address" chainStatus="icon" showBalance={false}/>;
};

const App = () => {
  const [authenticationStatus, setAuthenticationStatus] = useState('unauthenticated');
  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <RainbowKitAuthenticationProvider
          adapter={authenticationAdapter}
        >
          <RainbowKitProvider>
            <YourApp />
          </RainbowKitProvider>
        </RainbowKitAuthenticationProvider>
      </QueryClientProvider>
    </WagmiProvider>
  );
};

export default class extends Controller {
  connect() {
    console.log("wallet_controller connected")
    createRoot(this.element).render(<App />);
  }
}
