import { Controller } from "@hotwired/stimulus"
import React from 'react';
import { createRoot } from 'react-dom/client';

import {
  getDefaultConfig,
  RainbowKitProvider,
} from '@rainbow-me/rainbowkit';
import { WagmiProvider } from 'wagmi';
import {
  mainnet,
  polygon,
  optimism,
  arbitrum,
  base,
} from 'wagmi/chains';
import {
  QueryClientProvider,
  QueryClient,
} from "@tanstack/react-query";

import { ConnectButton } from '@rainbow-me/rainbowkit';
import { http } from 'wagmi';

const config = getDefaultConfig({
  appName: 'My RainbowKit App',
  projectId: '873f70fa626990b1ee3c14d55130a573',
  chains: [mainnet, polygon, optimism, arbitrum, base],
  transports: {
    [mainnet.id]: http(),
    [polygon.id]: http(),
    [optimism.id]: http(),
    [arbitrum.id]: http(),
    [base.id]: http(),
  },
  ssr: false, // If your app uses SSR, set this to true
});

// Create a client
const queryClient = new QueryClient();

const YourApp = () => {
  return <ConnectButton accountStatus="address" chainStatus="icon" showBalance={false}/>;
};

const App = () => {
  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <RainbowKitProvider>
          <YourApp />
        </RainbowKitProvider>
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
