class UApiUrl {
  static const String baseLink = 'https://www.hisabplus.com/Values/';
  static const String imageBaseLink = 'https://www.Hisabplus.com/';
  
   static String loginApi({
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
