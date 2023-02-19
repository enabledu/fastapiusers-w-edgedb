CREATE MIGRATION m1nlze4v3ibgi2vlfq3fxbznf5jyq5mgdtpjwnwys6hzguhnv76isq
    ONTO initial
{
  CREATE FUTURE nonrecursive_access_policies;
  CREATE TYPE default::EdgeAccessTokenUser {
      CREATE REQUIRED PROPERTY created_at -> std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE REQUIRED PROPERTY token -> std::str {
          CREATE CONSTRAINT std::exclusive;
      };
  };
  CREATE TYPE default::EdgeBaseOAuthUser {
      CREATE REQUIRED PROPERTY access_token -> std::str;
      CREATE REQUIRED PROPERTY account_email -> std::str {
          CREATE CONSTRAINT std::regexp(r'^[A-Za-z0-9\.\+_-]+@[A-Za-z0-9\._-]+\.[a-zA-Z]*$');
      };
      CREATE REQUIRED PROPERTY account_id -> std::str;
      CREATE PROPERTY expires_at -> std::int32;
      CREATE REQUIRED PROPERTY oauth_name -> std::str;
      CREATE PROPERTY refresh_token -> std::str;
  };
  CREATE TYPE default::EdgeBaseUser {
      CREATE MULTI LINK access_tokens -> default::EdgeAccessTokenUser {
          ON SOURCE DELETE DELETE TARGET;
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE MULTI LINK oauth_accounts -> default::EdgeBaseOAuthUser {
          ON SOURCE DELETE DELETE TARGET;
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY email -> std::str {
          CREATE CONSTRAINT std::exclusive;
          CREATE CONSTRAINT std::regexp(r'^[A-Za-z0-9\.\+_-]+@[A-Za-z0-9\._-]+\.[a-zA-Z]*$');
      };
      CREATE REQUIRED PROPERTY hashed_password -> std::str;
      CREATE REQUIRED PROPERTY is_active -> std::bool;
      CREATE REQUIRED PROPERTY is_superuser -> std::bool;
      CREATE REQUIRED PROPERTY is_verified -> std::bool;
  };
};
