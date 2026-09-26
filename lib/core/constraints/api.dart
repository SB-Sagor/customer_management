class UApiUrl {
  static const String baseLink = 'https://www.hisabplus.com/Values/';
  static const String imageBaseLink = 'https://www.Hisabplus.com/';
  // static const String token =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiIxMzAiLCJDdXJyZW50Q29tSWQiOiIxIiwibmJmIjoxNzkwMzMyMjkyLCJleHAiOjE3OTA5MzcwOTIsImlhdCI6MTc5MDMzMjI5Mn0.K1ieq_ETdJlGFRkw5ypW32VQ4ed8Bv3bNgzxwngbd9M';
  // static String loginApi({
    required String userName,
    required String password,
    int comId = 1,
  }) => '${baseLink}LogIn?UserName=$userName&Password=$password&ComId=$comId';

  static String getCustomerListApi({
    String searchQuery = '',
    int pageNo = 1,
    pageSize = 20,
    String sortBy = 'Balance',
  }) =>
      '${baseLink}GetCustomerList?searchquery=$searchQuery&pageNo=$pageNo&pageSize=$pageSize&SortyBy=$sortBy';
}
