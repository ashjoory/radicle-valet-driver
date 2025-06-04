# Valet Custom Driver For Radicle Local Setup On Herd/Valet

This package provides a custom Valet driver for Bedrock/Radicle-style WordPress projects. It automatically maps Valet to the `/public` directory and handles trailing slashes for `/wp/wp-admin`.

## Installation

1. Add the repository to your `composer.json`:

```
"repositories": [
  {
    "type": "vcs",
    "url": "https://github.com/your-vendor/valet-custom-driver"
  }
]
```

2. Require the package:

```
composer require your-vendor/valet-custom-driver:dev-main
```

3. The driver will be copied to your project root as `LocalValetDriver.php`.
