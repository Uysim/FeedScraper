every 1.hours do
  rake "perform:fetch", , environment: 'production'
end
