requirejs.config({
  urlArgs: 'v=v1423449266689',
  baseUrl: '/js',
  packages: [
    {
      name: 'sc',
      location: 'packages/simple-component'
    }
  ],
  paths: {
    jquery: 'vendor/jquery/dist/jquery',
    lodash: 'vendor/lodash/lodash',
    angular: 'vendor/angular/angular',
    angularAMD: 'vendor/angularAMD/angularAMD',
    'angular-ui-router': 'vendor/angular-ui-router/release/angular-ui-router',
    'bootstrap-daterangepicker': 'vendor/bootstrap-daterangepicker/daterangepicker',
    moment: 'vendor/moment/moment',
   // echarts: 'vendor/echarts',
    'jquery.honey.pagination': 'vendor/jquery.honey.pagination/jquery.honey.pagination',
    'angular-bind-hash': "vendor/angular-bind-hash/angular-bind-hash"
  },
  shim: {
    angular: {
      exports: 'angular'
    },
    angularAMD: [
      'angular'
    ],
    'angular-ui-router': {
      deps: [
        'angular'
      ]
    },
    lodash: {
      exports: '_'
    },
    'bootstrap-daterangepicker': {
      deps: ['jquery', 'moment']
    }
  },
  deps: [
    'app'
  ]
});
