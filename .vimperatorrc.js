// vim:sw=2 ts=2 et si fdm=marker:

liberator.echo('.vimperatorrc.js loading');

(function () {

  // ウィンドウタイトルにプロファイル名を挿入する。
  let profile_name = liberator.profileName;
  let title_string = 'Vimp (' + profile_name + ')';
  liberator.modules.options.get('titlestring').set(title_string);

  // _smooziee.js
  liberator.globalVariables.smooziee_scroll_amount = '20';
  liberator.globalVariables.smooziee_scroll_interval = '10';

  // char-hints-mod2.js
  liberator.globalVariables.hintsio = 'iO';
  liberator.globalVariables.hintchars = 'HJKLASDFGYUIOPQWERTNMZXCVB';


  // direct_bookmark.js
  liberator.globalVariables.direct_sbm_use_services_by_tag = 'h'
  liberator.globalVariables.direct_sbm_use_services_by_post = 'dh'

  // ime_controller.js
  liberator.globalVariables.ex_ime_mode = 'inactive'
  liberator.globalVariables.textarea_ime_mode = 'inactive'

  // maine_coon.js
  liberator.globalVariables.maine_coon_default = 'ac'

  // twittperator (twlist-win)
  // {{{
  liberator.globalVariables.twittperator_use_ssl_connection_for_api_ep = 1;
  // http://vimperator.g.hatena.ne.jp/nokturnalmortum/20100731/1280583279
  liberator.globalVariables.twittperator_use_chirp = 1;
  //liberator.globalVariables.twittperator_plugin_urusai_namakubi = 1
  //liberator.globalVariables.twittperator_plugin_echo_tweet = 1

  // http://vimperator.g.hatena.ne.jp/teramako/20100920/1284933936
  liberator.globalVariables.twittperator_track_words = <><![CDATA[
    #brussels
    #bunkyo
    #mixi
    #vimp
    #vimperator
    bunkyo
    mixi
    vimp
    vimperator
    ブラッセルズ
  ]]></>.toString().replace(/(^\s+)|(\s+$)/g, '').split(/\s+/).join(',');
  liberator.globalVariables.twlist_track_words = <><![CDATA[
    #brussels,ブラッセルズ
    #bunkyo,bunkyo
    #mixi,mixi
    #vimp,#vimperator,vimp,vimperator
  ]]></>.toString().replace(/(^\s+)|(\s+$)/g, '').split(/\s+/);
  // }}}

  // Plugins
  // {{{
  liberator.globalVariables.plugin_loader_plugins = <><![CDATA[
    _libly
    _smooziee
    alias
    appendAnchor
    asdfghjkl
    auto_reload
    auto_source
    bitly
    caret-hint
    commandBookmarklet
    direct_bookmark
    edit-vimperator-files
    feedSomeKeys_3
    foxage2ch
    gmail-commando
    hints-for-embedded
      hints-yank-paste
    jscompletion
    lo
    memo
    multi-exec
    multi_requester
    onclick
    opener
    pino
    sbmcommentsviewer
    statusline-toolbar
    stella
    twissr
    twittperator
    video-controller
    walk-input
    wassr
    x-hint
  ]]></>.toString().split(/\s+/).filter(function(n) !/^!/.test(n));
  // }}}

})();


liberator.echo('.vimperatorrc.js loaded');
liberator.registerObserver('enter', function () liberator.echo('Initialized.'));
