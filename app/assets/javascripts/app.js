app = angular.module("App", ["ngAnimate"])

app.factory("fromoutside", [
  "$window", function($window) {
     $window.pubnub = PUBNUB.init({
       publish_key: 'pub-75a3aad0-d9c8-4763-8838-9aae1226ed0c',
       subscribe_key: 'sub-fdd15440-8939-11e1-aa2b-41374c390533'
   });
  }
]);