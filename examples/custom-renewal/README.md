# Custom certificate renewal

If you want to customize how often the application checks and renews the
sidecar certificate, use the variables `renewal_interval_checks` and
`renewal_interval_window_start`.

For the configuration provided here, the application will check the certificate
every day and renew it if there are no more than 30 days left until it expires.
