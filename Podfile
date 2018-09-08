def import_pods
pod 'Alamofire', '~> 4.7'
  pod 'BigInt', '~> 3.0'
  pod 'Result', '~> 3.0'
  pod 'libsodium', '~> 1.0'
  pod 'CryptoSwift', '~> 0.10'
  pod 'secp256k1_ios', :git => 'https://github.com/shamatar/secp256k1_ios.git', :modular_headers => true
  pod 'web3swift', :git => 'https://github.com/Kimlic/web3swift', :branch => 'quorum', :modular_headers => true
  pod 'Quorum', :git => 'https://github.com/Kimlic/Quorum-iOS'
end

target 'Quorum-iOS-Demo' do
  platform :ios, '9.0'
  use_frameworks!

  import_pods
end