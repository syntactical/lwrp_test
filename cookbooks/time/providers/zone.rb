

action :set do
	if @current_resource.already_set
		Chef::Log.info("time zone already set. Nothing to do.")
	else
		converge_by("Setting time zone...") do
			set_time_zone
		end
	end
end

def load_current_resource
	@current_resource = Chef::Resource::TimeZone.new(@new_resource.name)
	@current_resource.timezone(@new_resource.timezone)
	@current_resource.already_set = system("[ \"$TZ\" = \"#{@current_resource.timezone}\" ]")
end

def set_time_zone
	ENV['TZ'] = @current_resource.timezone
end


