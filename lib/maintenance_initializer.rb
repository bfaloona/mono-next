module MaintenanceInitializer
  def self.registered(app)
    app.use Rack::Maintenance, :file => Padrino.root('public/maintenance.html') #, :env  => 'MAINTENANCE'

  end
end
