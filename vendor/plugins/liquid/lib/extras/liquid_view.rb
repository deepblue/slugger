# LiquidView is a action view extension class. You can register it with rails
# and use liquid as an template system for .liquid files
#
# Example
# 
#   ActionView::Base::register_template_handler :liquid, LiquidView
class LiquidView

  def initialize(action_view)
    @action_view = action_view
  end
  

  def render(template, local_assigns)
    @action_view.controller.headers["Content-Type"] ||= 'text/html; charset=utf-8'
    assigns = @action_view.assigns.dup
    
    if content_for_layout = @action_view.instance_variable_get("@content_for_layout")
      assigns['content_for_layout'] = content_for_layout
    end
    assigns.merge!(local_assigns)
    
    liquid = Liquid::Template.parse(template)
    ret = liquid.render(assigns, :filters => [@action_view.controller.master_helper_module], :registers => {:action_view => @action_view, :controller => @action_view.controller})
    
    #Just add the errors to the logger...Simple
    if RAILS_DEFAULT_LOGGER && RAILS_DEFAULT_LOGGER.debug?
      msg = ""
      liquid.errors.each do |exception|
        msg << "[Liquid Error] #{exception.message} trace: \n#{exception.backtrace.join("\n")}"
        msg << "\n\n"
      end
      RAILS_DEFAULT_LOGGER.debug msg
    end
    
    ret
  end

end