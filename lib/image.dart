var articleImageMap = Map<String, List<String>>();

var articleImageFilePathMap = Map<String, Map<String, String>>();

void addImageToArticleImageMap(String articleId, List<String> imageList) {
  if (articleImageMap.containsKey(articleId)) {
    articleImageMap.update(articleId, (value) => value..addAll(imageList));
  } else {
    articleImageMap.putIfAbsent(articleId, () => imageList);
  }
}

void insertImageToArticleImageMap(
    String articleId, List<String> imageList, int index) {
  if (articleImageMap.containsKey(articleId)) {
    articleImageMap.update(
        articleId, (value) => value..insertAll(index, imageList));
  } else {
    articleImageMap.putIfAbsent(articleId, () => imageList);
  }
}

List<String> getArticleImageList(String articleId) {
  return articleImageMap.putIfAbsent(articleId, () => []);
}

void addImageToArticleImageFilePathMap(
    String articleId, String imageUrl, String filePath) {
  if (articleImageFilePathMap.containsKey(articleId)) {
    articleImageFilePathMap.update(
        articleId, (value) => value..putIfAbsent(imageUrl, () => filePath));
  } else {
    articleImageFilePathMap.putIfAbsent(articleId, () => {imageUrl: filePath});
  }
}

Map<String, String> getArticleImageUrlFilePathList(String articleId) {
  return articleImageFilePathMap[articleId];
}
