<?php

namespace Ashjoory\RadicleValetDriver;

use Composer\Composer;
use Composer\EventDispatcher\EventSubscriberInterface;
use Composer\IO\IOInterface;
use Composer\Plugin\PluginInterface;
use Composer\Script\Event;
use Composer\Script\ScriptEvents;

class Plugin implements PluginInterface, EventSubscriberInterface
{
    public function activate(Composer $composer, IOInterface $io) {}

    public static function getSubscribedEvents(): array
    {
        return [
            ScriptEvents::POST_INSTALL_CMD => 'handle',
            ScriptEvents::POST_UPDATE_CMD => 'handle',
        ];
    }

    public static function handle(Event $event)
    {
        $projectRoot = getcwd();
        $source = $projectRoot . '/vendor/ashjoory/radicle-valet-driver/src/LocalValetDriver.php';
        $target = $projectRoot . '/LocalValetDriver.php';
        $gitignore = $projectRoot . '/.gitignore';

        if (file_exists($source)) {
            copy($source, $target);
            $event->getIO()->write("<info>✅ LocalValetDriver.php copied to project root.</info>");

            if (!file_exists($gitignore) || !preg_match('/^LocalValetDriver\.php$/m', file_get_contents($gitignore))) {
                file_put_contents($gitignore, "\nLocalValetDriver.php", FILE_APPEND);
                $event->getIO()->write("<info>📝 .gitignore updated.</info>");
            }
        }
    }
}
