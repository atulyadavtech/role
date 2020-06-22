yum install ganglia rrdtool ganglia-gmetad ganglia-gmond ganglia-web

/etc/httpd/conf.d/ganglia.conf

Allow from all
Require all granted



verify the File
gmond -f -c /etc/ganglia/gmond.conf
