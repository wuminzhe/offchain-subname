import '@rainbow-me/rainbowkit/styles.css';

import { Controller } from "@hotwired/stimulus"
import ReactDOM from 'react-dom';
import React from 'react';

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
const YourApp = () => {
  return <ConnectButton />;
};

const config = getDefaultConfig({
  appName: 'My RainbowKit App',
  projectId: '873f70fa626990b1ee3c14d55130a573',
  chains: [mainnet, polygon, optimism, arbitrum, base],
  ssr: false,
});

const queryClient = new QueryClient();

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
    console.log("hello_controller connected")
    ReactDOM.render(<App />, this.element);
  }
}
