//
//  GADBannerViewController.swift
//  SUMAI
//
//  Created by 서영규 on 2021/02/22.
//
import SwiftUI
import GoogleMobileAds

struct GADBannerViewController: UIViewControllerRepresentable {

    @State private var banner: GADBannerView = GADBannerView(adSize: kGADAdSizeBanner)

    func makeUIViewController(context: Context) -> UIViewController {
        let bannerSize = GADBannerViewController.getAdBannerSize()
        let viewController = UIViewController()
        banner.adSize = bannerSize
        banner.adUnitID = AdmobData.bannerId
        banner.rootViewController = viewController
        viewController.view.addSubview(banner)
        viewController.view.frame = CGRect(origin: .zero, size: bannerSize.size)
        banner.load(GADRequest())
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
        let bannerSize = GADBannerViewController.getAdBannerSize()
        banner.frame = CGRect(origin: .zero, size: bannerSize.size)
        banner.load(GADRequest())
    }

    static func getAdBannerSize() -> GADAdSize {
        if let rootView = UIApplication.shared.windows.first?.rootViewController?.view {
            let frame = rootView.frame.inset(by: rootView.safeAreaInsets)
            return GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(frame.width)
        }
        //No root VC, use 320x50 ad banner
        return kGADAdSizeBanner
    }
}

final class GADInterstitialController : NSObject, GADInterstitialDelegate {
    var interstitial : GADInterstitial!
    
    override init() {
        super.init()
        loadInterstitial()
    }
    
    func loadInterstitial() {
        self.interstitial = GADInterstitial(adUnitID: AdmobData.interstitialId)
        self.interstitial.load(GADRequest())
        self.interstitial.delegate = self
    }
    
    func showAd() {
        if self.interstitial.isReady{
            let root = UIApplication.shared.windows.first?.rootViewController
            self.interstitial.present(fromRootViewController: root!)
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.loadInterstitial()
    }
    
}
