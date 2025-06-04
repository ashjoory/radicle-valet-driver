# Custom Driver For Radicle Local Setup On Herd/Valet

This package provides a custom Valet driver tailored for Bedrock/Radicle-style WordPress projects to be used exclusively in local development environments. It ensures Valet serves the `/public` directory and properly handles trailing slashes for `/wp/wp-admin`. This driver is intended for local use only and should not be deployed to production.

## Installation

1. Install the package as a development dependency via Packagist:

```bash
composer require --dev ashjoory/radicle-valet-driver
```

2. Upon installation, the driver file `LocalValetDriver.php` will be automatically copied to your project root if it does not already exist. The file is also added to your `.gitignore` to prevent it from being committed to your repository.

## Purpose

- Provide a seamless local development experience for Radicle/Bedrock WordPress projects using Valet or Herd.
- Automatically map Valet to the correct `/public` directory.
- Handle trailing slashes for `/wp/wp-admin` routes correctly.
- Ensure the driver is only used in local environments by keeping it out of version control.

## Notes

- This driver should not be used or deployed in production environments.
- The automatic copying and `.gitignore` management help maintain a clean project setup without manual steps.
- If you need to customize the driver, edit the copied `LocalValetDriver.php` in your project root.
