(function(){
  dactyl.echo('.pentadactylerc.js loading');

  dactyl.echo('.pentadactylerc.js loaded');
  dactyl.registerObserver('enter', function(){
    dactyl.echo('Initialized.')
  });
})();

// vim set ft=javascript
