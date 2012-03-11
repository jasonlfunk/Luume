module ProjectsHelper
  def get_users_projects
    return [] unless logged_in? 
    projects = []
    logger.info current_user.clients.count.to_s + " Clients"
    current_user.clients.each do |client|
      logger.info client.projects
      projects += client.projects
    end
    logger.info projects 
    return projects
  end
end
