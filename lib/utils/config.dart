class ConFig {
  bool nightMode;
  bool swipeHorizontal;
  bool autoSpacing;
  bool pageFling;
  bool pageSnap;
  bool enableImmersive;
  bool autoPlay;
  bool forceLandscape;
  bool slideShow;

  ConFig() {
    nightMode = false;
    swipeHorizontal = false;
    autoSpacing = false;
    pageFling = false;
    pageSnap = false;
    enableImmersive = false;
    autoPlay = false;
    forceLandscape = false;
    slideShow = false;
  }

  Map<String, dynamic> toJson() => {
        'nightMode': nightMode,
        'swipeHorizontal': swipeHorizontal,
        'autoSpacing': autoSpacing,
        'pageFling': pageFling,
        'pageSnap': pageSnap,
        'enableImmersive': enableImmersive,
        'autoPlay': autoPlay,
        'forceLandscape': forceLandscape,
        'slideShow': slideShow
      };
  ConFig.fromJson(Map<String, dynamic> json)
      : nightMode = json['nightMode'],
        swipeHorizontal = json['swipeHorizontal'],
        autoSpacing = json['autoSpacing'],
        pageFling = json['pageFling'],
        pageSnap = json['pageSnap'],
        enableImmersive = json['enableImmersive'],
        autoPlay = json['autoPlay'],
        forceLandscape = json['forceLandscape'],
        slideShow = json['slideShow'];
}
