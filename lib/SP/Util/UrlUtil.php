<?php


namespace SP\Util;


use SP\Config\ConfigData;
use SP\Core\Acl\Acl;
use SP\Core\Acl\ActionsInterface;
use SP\Bootstrap;
use SP\Http\Uri;

final class UrlUtil
{
    /**
     * @param ConfigData $configData
     * @param $accountId
     * @return string
     */
    public static function getDeepLink(ConfigData $configData, $accountId)
    {
        $baseUrl = ($configData->getApplicationUrl() ?: Bootstrap::$WEBURI) . Bootstrap::$SUBURI;
        $baseUrl = str_replace("api.php", "index.php", $baseUrl);
        $deepLink = new Uri($baseUrl);
        $deepLink->addParam('r', 'account/view/' . $accountId);
        $uri_signed = $deepLink->getUriSigned($configData->getPasswordSalt());

        return self::getShortUrl($configData, $uri_signed);
    }

    /**
     * @param $configData
     * @param $url
     * @return false|string
     */
    public static function getShortUrl($configData, $url)
    {
        $polrUrl =$configData->getPolrUrl();
        $polrApiKey = $configData->getPolrApiKey();

        if (!$polrUrl || !$polrApiKey)
            return $url;

        return file_get_contents($polrUrl."/api/v2/action/shorten?key=".$polrApiKey."&url=".urlencode($url));
    }
}