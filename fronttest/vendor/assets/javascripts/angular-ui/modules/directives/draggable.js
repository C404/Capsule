
function evalFn(element, scope, exp, property){
  property = property || '$token';
  return function(token){
    var old = scope.hasOwnProperty(property) ? scope[property] : undefined;
    scope[property] = token;
    var retVal = scope.$eval(exp, element);
    scope[property] = old;
    return retVal;
  };
};

angular.module('ui.directives', [])
  .directive('jquiDragStart', function ($compile) {
  return {
    link:function (scope, item, attrs) {
      var dragStartExp = attrs.jquiDragStart || '';
      var dragEndExp = attrs.jquiDragEnd || '';
      var handle = attrs.jquiHandle || false;
      var axisExp = attrs.jquiAxis;
      
      item.addClass('jqui-dnd-item');
      
      var dragStart = evalFn(item, scope, dragStartExp);
      var dragEnd = evalFn(item, scope, dragEndExp);
      var token;
      
      item.draggable({
        addClass:false,
        handle:handle,
        start:function (event, ui) {
          item.draggable('option', 'revertDuration', 200);
          item.addClass('jqui-dnd-item-dragging');
          item.data('jqui-dnd-item-token', token = dragStart());
          scope.$apply();
        },
        stop:function () {
          item.removeClass('jqui-dnd-item-dragging');
          item.removeClass('jqui-dnd-item-over');
          item.removeData('jqui-dnd-item-token');
          dragEnd(token);
          scope.$apply();
          token = null;
        },
        revert:true
      });
          
          if (axisExp) {
            scope.$watch(axisExp, function (newValue) {
              item.draggable('option', 'axis', newValue);
            });
          }
    }
  }
})
          
          .directive('jquiDropCommit', function ($compile) {
            return {
              link:function (scope, target, attrs) {
                var acceptExp = attrs.jquiDropAccept || '';
                var commitExp = attrs.jquiDropCommit || '';
                
                target.addClass('jqui-dnd-target');
          var accept = evalFn(target, scope, acceptExp);
          var commit = evalFn(target, scope, commitExp);
          
          target.droppable({
            addClass:false,
            activate:function (event, ui) {
              var token = ui.draggable.data('jqui-dnd-item-token');
              if (accept(token)) {
                target.addClass('jqui-dnd-target-active');
              } else {
                target.addClass('jqui-dnd-target-disable');
              }
              scope.$apply();
            },
            deactivate:function () {
              target.removeClass('jqui-dnd-target-active');
              target.removeClass('jqui-dnd-target-disable');
              target.removeClass('jqui-dnd-target-over');
            },
            over:function (event, ui) {
              if (target.hasClass('jqui-dnd-target-active')) {
                target.addClass('jqui-dnd-target-over');
                ui.draggable.addClass('jqui-dnd-item-over');
              }
            },
            out:function (event, ui) {
              target.removeClass('jqui-dnd-target-over');
              ui.draggable.removeClass('jqui-dnd-item-over');
            },
            drop:function (event, ui) {
              if (target.hasClass('jqui-dnd-target-active')) {
                commit(ui.draggable.data('jqui-dnd-item-token'));
                ui.draggable.draggable('option', 'revertDuration', 0);
                ui.draggable.css({top:'', left:''});
                ui.draggable.draggable('option', 'stop')();
              }
              target.removeClass('jqui-dnd-target-active');
              target.removeClass('jqui-dnd-target-disable');
              target.removeClass('jqui-dnd-target-over');
            }
          });
              }
            }
          });
