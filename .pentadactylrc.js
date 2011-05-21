(function(){
  dactyl.echo('.pentadactylerc.js loading');

  // For plugin_loader.js {{{
  options['plugin_loader_roots'] = [
    '~/scm/vimperator-plugins-pentadactyl',
  ];
  options['plugin_loader_plugins'] = [
     '_libly',
     'foxage2ch',
     'pluginManager',
     'twissr',
     'twittperator',
  ];
  // }}}

  // For twittperator.js {{{
  options['twittperator_use_ssl_connection_for_api_ep'] = 1;
  // http://vimperator.g.hatena.ne.jp/nokturnalmortum/20100731/1280583279
  options['twittperator_use_chirp'] = 1;
  // options['twittperator_plugin_urusai_namakubi'] = 1
  // options['twittperator_plugin_echo_tweet'] = 1
  // }}}

  // For Chaika {{{
  config.dialogs['chaika'] = [
    'Chaika',
    function(){
      openUILinkIn('chrome://chaika/content/bbsmenu/page.xul', 'tab');
    },
  ];
  // }}}

  // For Foxage2ch {{{
  config.dialogs['foxage2ch'] = [
    'Foxage2ch',
    function(){
      openUILinkIn('chrome://foxage2ch/content/foxage2ch.xul', 'tab');
    },
  ];
  // }}}

  dactyl.echo('.pentadactylerc.js loaded');
  dactyl.registerObserver('enter', function(){
    dactyl.echo('Initialized.')
  });
})();

// vim set ft=javascript
