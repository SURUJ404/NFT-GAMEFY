// import { Address, erc20ABI } from 'wagmi';
// import { Abi, PublicClient, WalletClient, getContract as viemGetContract } from 'viem';

// export const getContract = <TAbi extends Abi | unknown[]>({
//   abi,
//   address,
//   publicClient,
//   walletClient,
// }: {
//   abi: TAbi;
//   address: Address;
//   walletClient?: WalletClient;
//   publicClient?: PublicClient;
// }) => {
//   const c = viemGetContract({
//     abi,
//     address,
//     publicClient: publicClient,
//     walletClient: walletClient,
//   });
//   return {
//     ...c,
//     account: walletClient?.account,
//     chain: walletClient?.chain,
//   };
// };

// export const getErc20Contract = (address: Address, walletClient?: WalletClient) => {
//   return getContract({ abi: erc20ABI, address, walletClient });
// };






import { Address, erc20ABI } from 'wagmi';
import {
  Abi,
  PublicClient,
  WalletClient,
  getContract as viemGetContract,
} from 'viem';

type GetContractParams<TAbi extends Abi> = {
  abi: TAbi;
  address: Address;
  walletClient?: WalletClient;
  publicClient?: PublicClient;
};

export const getContract = <TAbi extends Abi>({
  abi,
  address,
  publicClient,
  walletClient,
}: GetContractParams<TAbi>) => {
  if (!publicClient && !walletClient) {
    throw new Error('Either publicClient or walletClient must be provided');
  }

  const contract = viemGetContract({
    abi,
    address,
    publicClient,
    walletClient,
  });

  return {
    ...contract,
    account: walletClient?.account ?? null,
    chain: walletClient?.chain ?? null,
  };
};

export const getErc20Contract = ({
  address,
  walletClient,
  publicClient,
}: {
  address: Address;
  walletClient?: WalletClient;
  publicClient?: PublicClient;
}) => {
  return getContract({
    abi: erc20ABI,
    address,
    walletClient,
    publicClient,
  });
};