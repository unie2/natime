/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	config.filebrowserImageUploadUrl = 'upload.jsp';
	config.enterMode = CKEDITOR.ENTER_BR; 
	config.toolbar = [
	                  ['Font', 'FontSize'],
	                  ['BGColor', 'TextColor' ],
	                  ['Bold', 'Italic', 'Strike', 'Superscript', 'Subscript', 'Underline','-', 'RemoveFormat'],   
	                  ['BidiLtr', 'BidiRtl'],
	                  '/',
	                  ['Image','Table', 'SpecialChar', 'Smiley'],
	                  ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
	                  [ 'NumberedList', 'BulletedList','Outdent','Indent','-','Blockquote','CreateDiv'],
	                  ['Link', 'Unlink'],
	                  ['Undo', 'Redo'],
	                  ['about']
	          ];
};
