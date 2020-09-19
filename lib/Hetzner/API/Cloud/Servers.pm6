use Hetzner::API::Cloud::Request;

role Hetzner::API::Cloud::Servers does Hetzner::API::Cloud::Request {
    method servers () {
        my $url  = $.server ~ $.path ~ 'servers';
        my $json = self!request(
            url => $url,
        );

        return $json<servers>;
    }
}
