import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'AdsInfo.dart';

class AdsFile {
  BuildContext? context;
  InterstitialAd? _interstitialAd;
  AdsFile(BuildContext c) {
    context = c;
  }
  BannerAd? _anchoredBanner;
  Future<void> createAnchoredBanner(BuildContext context, var setState,
      {Function? function}) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: getBannerAdUnitId(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
          if (function != null) {
            function();
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
      ),
    );
    return banner.load();
    // }
  }

  void disposeInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.dispose();
    }
  }

  void disposeBannerAd() {
    if (_anchoredBanner != null) {
      _anchoredBanner!.dispose();
    }
  }

  void showInterstitialAd(Function function) {
    if (_interstitialAd == null) {
      function();

      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {},
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        function();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: getInterstitialAdUnitId(),
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            _interstitialAd = null;

            createInterstitialAd();
          },
        ));
  }
}

getBanner(BuildContext context, AdsFile? adsFile) {
  if (adsFile == null) {
    return Container();
  } else {
    return showBanner(context, adsFile);
  }
}

showInterstitialAd(AdsFile? adsFile, Function function) {
  if (adsFile != null) {
    adsFile.showInterstitialAd(() {
      function();
    });
  } else {
    function();
  }
}

disposeInterstitialAd(AdsFile? adsFile) {
  if (adsFile != null) {
    adsFile.disposeInterstitialAd();
  }
}

disposeBannerAd(AdsFile? adsFile) {
  if (adsFile != null) {
    adsFile.disposeBannerAd();
  }
}

showBanner(BuildContext context, AdsFile adsFile) {
  return Container(
    height: (getBannerAd(adsFile) != null)
        ? getBannerAd(adsFile)!.size.height.toDouble()
        : 0,
    // color: Colors.black,
    color: Theme.of(context).scaffoldBackgroundColor,
    child: (getBannerAd(adsFile) != null)
        ? AdWidget(ad: getBannerAd(adsFile)!)
        : Container(),
  );
}

BannerAd? getBannerAd(AdsFile? adsFile) {
  BannerAd? anchoredBanner;
  if (adsFile != null) {
    return (adsFile._anchoredBanner == null)
        ? anchoredBanner
        : adsFile._anchoredBanner!;
  } else {
    return anchoredBanner!;
  }
}
