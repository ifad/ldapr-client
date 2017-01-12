module LDAPR
  module Helpers
    def thumbnail_data
      Base64.encode64(File.read("#{File.dirname(__FILE__)}/thumbnail.jpeg"))
    end

    def ldap_base
      ENV['LDAP_SERVER_BASE']
    end

    def dn_for_account_name(account_name)
      "CN=#{account_name},#{ldap_base}"
    end

    def create(
      account_name: 'test.account',
      objectClass: ["top", "person", "organizationalPerson", "user"],
      proxyAddresses: ["address1", "address2"],
      mail: "#{account_name}@ifad.org")


      dn = dn_for_account_name(account_name)

      attributes = {
        "id":                 dn,
        "givenName":          account_name,
        "sn":                 "last",
        "displayName":        account_name,
        "mail":               mail,
        "sAMAccountName":     account_name,
        "userPrincipalName":  "#{account_name}@ifad.org",
        "userAccountControl": "544",
        "objectClass":        objectClass,
        "cn":                 account_name,
        "employeeNumber":     account_name,
        "proxyAddresses":     proxyAddresses,
        "thumbnailPhoto":     thumbnail_data
      }

      entry = LDAPR::Entry.new(attributes, auth_params)
      entry.save!
    end

    def find(dn)
      LDAPR::Entry.find(escaped_dn(dn), auth_params)
    end

    private
      def escaped_dn(dn)
        CGI::escape(dn)
      end

      def auth_params
        {
          username: ENV['LDAP_SERVER_USERNAME'],
          password: ENV['LDAP_SERVER_PASSWORD']
        }
      end
  end
end
