use Cro::HTTP::Client;

role Hetzner::API::Cloud::Request {
    has Cro::HTTP::Client $!client;
    has Str $.server = 'https://api.hetzner.cloud/';
    has Str $.path   = 'v1/';

    submethod BUILD ( Str :$api_token! ) {
        $!client = Cro::HTTP::Client.new:
            headers => [
                Authorization => 'Bearer ' ~ $api_token,
            ]
        ;
    }

    method !request (:$url, :%query) {
        my $resp = await $!client.get: 
            $url,
            query => %query,
        ;   
        CATCH {
            when X::Cro::HTTP::Error {
                return %();
            }
        }
         
        my $json = await $resp.body;
         
        return $json;
    }

}
