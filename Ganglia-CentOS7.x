yum install ganglia rrdtool ganglia-gmetad ganglia-gmond ganglia-web

/etc/httpd/conf.d/ganglia.conf

Alias /ganglia /usr/share/ganglia

<Directory "/usr/share/ganglia">
	AllowOverride All
  Require all granted
</Directory>




verify the File
gmond -f -c /etc/ganglia/gmond.conf
