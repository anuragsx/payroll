(function($){$.fn.extend({accordion:function(){return this.each(function(){if($(this).data('accordiated'))return false;$.each($(this).find('ul, li>div'),function(){$(this).data('accordiated',true);$(this).hide()});$.each($(this).find('a:not(.foo)'),function(){$(this).hoverIntent(function(e){activate(e.target);return void(0)},function(e){})});var d=false;if(location.hash)d=$(this).find('a[href='+location.hash+']')[0];else if($(this).find('li.current'))d=$(this).find('li.current a')[0];if(d){activate(d,'toggle','parents');$(d).parents().show()}function activate(a,b,c){$(a)[(c||'parent')]('li').toggleClass('active').siblings().removeClass('active').children('ul, div').slideUp('fast');$(a).siblings('ul, div')[(b||'slideToggle')]((!b)?'fast':null)}})}})})(jQuery);