module ApplicationHelper
  def link_to_name obj, attribute = nil
    return '' unless obj
    if attribute
      link_to obj.send(attribute), obj
    else
      link_to obj.name, obj
    end
  end
  
  def main_nav
    link_to('New Commission', new_commission_path, :id => 'new_commission_link') +
    link_to('Commissions', commissions_path, :id => 'commissions_link') +
    link_to('Documents', documents_path) +
    if current_agent.admin?
      link_to('Deals', deals_path) +
      link_to('Assistants', assistants_path) +
      link_to('Assists', assists_path) +
      link_to('Documents', documents_path) +
      link_to('Agents', agents_path) +
      link_to('Landlords', landlords_path)
    end
  end
  
  def penthouse_nav
    content_tag :nav, :id => 'top_floor_penthouse_navigation' do
      if current_agent
        main_nav +
        link_to('Sign Out', destroy_agent_session_path, :method => :delete, :id => 'sign_out_link') +
        link_to('Me', edit_agent_path(current_agent), :id => 'profile_link')
      else
        link_to('Log In', new_agent_session_path) +
        link_to('Register', new_agent_registration_path)
      end
    end
  end
  
  def clearboth
    tag.div :class => 'clearboth'
  end
  
  def google_fonts
    google_webfonts_init :google => selected_fonts
  end
  
  def selected_fonts
    ['Arvo', 'Bitter', 'Cinzel', 'Fjalla One', 'Jua', 'M PLUS Rounded 1c', 'Nunito']
  end
end
