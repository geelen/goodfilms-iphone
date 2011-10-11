echo EGOTableViewPullRefresh
mkdir -p src-external
wget -O src-external/EGOTableViewPullRefresh.tar.gz https://github.com/enormego/EGOTableViewPullRefresh/tarball/master

pushd src-external
tar zxvf EGOTableViewPullRefresh.tar.gz
mv enormego-*/EGOTableViewPullRefresh .
rm -rf enormego-*
rm EGOTableViewPullRefresh.tar.gz
popd
