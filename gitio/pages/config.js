'use strict';

var config = (function () {
    var DEFAULT_PAGE = 'index';
    var DEFAULT_ROOT = 'main';
    return {
// personnal settings
        SITE_NAME: 'Ideal Cobol',
        SITE_DESCRIPTION: 'a little CMS in Javascript',
        SITE_TITLE: 'Ideal Cobol: ',
        AUTHORS: 'Bernard Tatin',
        COPYRIGHT: '(c) 2016',
        TOC_TITLE: 'chapters',
        // be carefull with that assignment, Eugene!
        SITE_BASE: "gitio/pages",
// don't touch that!
        DEFAULT_PAGE: DEFAULT_PAGE,
        DEFAULT_ROOT: DEFAULT_ROOT,
        UNDEFINED: undefined,
        current_root: DEFAULT_ROOT,
        current_page: DEFAULT_PAGE
    };
})();