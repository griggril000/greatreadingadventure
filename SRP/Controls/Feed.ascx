﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Feed.ascx.cs" Inherits="GRA.SRP.Controls.Feed" %>
<div class="row">
    <div class="col-xs-12 text-center">
        <span class="lead">Feed</span>
        <hr style="margin-bottom: 5px !important; margin-top: 5px !important;" />
    </div>
    <div class="col-xs-12" id="activity-feed">
    </div>
</div>

<script>
    var feedRootPath = '<%=Request.ApplicationPath%>';
    var feedCurrentPatronProgram = <%=CurrentPatronProgram%>;
    var firstFeedLoad = true;
    var feedUpdateId = 0;
    var feedLatest = 0;
    var feedRefreshCount = 0;

    $().ready(function () {
        loadFeed();
    });

    function loadFeed() {
        feedRefreshCount++;
        if (feedRefreshCount > 60) {
            // give up on updates after 30 minutes
            if (feedUpdateId > 0) {
                console.log("Giving up on feed updates, refresh the page to see new updates.");
                clearInterval(feedUpdateId);
            }
            return;
        }
        var jqxhr = $.ajax(feedRootPath + 'Handlers/Feed.ashx?after=' + feedLatest)
            .done(function (data, textStatus, jqXHR) {
                if (data.Success) {
                    if (data.Latest == 0 || data.Latest > feedLatest) {
                        var html = [];
                        var newLatest = feedLatest;
                        var addedRows = 0;
                        // new records
                        if (firstFeedLoad) {
                            html.push('<table class="feed-table" id="activity-feed-table">');
                        }
                        $.each(data.Entries, function (index, entry) {
                            if (entry["ID"] > feedLatest) {
                                addedRows++;
                                html.push('<tr class="animated bounceInLeft">');
                                if (entry.AvatarState) {
                                    html.push('<td class="feed-avatar">');
                                    html.push('<a href="' + feedRootPath + 'Images/AvatarCache/' + entry.AvatarState + '.png" class="fancybox">');
                                    html.push('<img style="height: 42px; width: 42px;" src="' + feedRootPath + 'Images/AvatarCache/sm_' + entry.AvatarState + '.png" class="margin-1em-right"/></td>');
                                    html.push('</a><td>');
                                } else {
                                    html.push('<td colspan="2">')
                                }
                                html.push('<strong>' + entry.Username + '</strong>');
                                switch (entry.AwardReasonId) {
                                    case 1:
                                        // badge
                                        html.push(' earned the badge: <a href="' + feedRootPath + 'Badges/Details.aspx?BadgeId=' + entry.BadgeId + '"');
                                        html.push('onClick="return HideTooltipShowBadgeInfo(this.parentElement, ' + entry.BadgeId + ');">' + entry.AchievementName + '</a>.');
                                        break;
                                    case 2:
                                        // challenge
                                        html.push(' completed the challenge: ');
                                        if(entry.ChallengeProgramId == 0
                                           || entry.ChallengeProgramId == feedCurrentPatronProgram) {
                                            html.push('<a href="' + feedRootPath + 'Challenges/Details.aspx?ChallengeId=' + entry.ChallengeId + '">');
                                            html.push(entry.AchievementName + '</a>');
                                        } else {
                                            html.push(entry.AchievementName);
                                        }
                                        if (entry.BadgeId && entry.BadgeId > 0) {
                                            html.push(' and <a href="' + feedRootPath + 'Badges/Details.aspx?BadgeId=' + entry.BadgeId + '"');
                                            html.push('onClick="return HideTooltipShowBadgeInfo(this.parentElement, ' + entry.BadgeId + ');">earned a badge</a>.');
                                        }
                                        break;
                                    case 4:
                                        // adventure
                                        html.push(' finished the ' + entry.AchievementName + ' <a href="' + feedRootPath + 'Adventures/">Adventure</a>.');
                                        break;
                                }
                                html.push('</td></tr>');
                                if (entry["ID"] > newLatest) {
                                    newLatest = entry["ID"];
                                }
                            }
                        });
                        if (firstFeedLoad && data.Latest == 0) {
                            // no data, show placeholder
                            html.push('<tr class="animated bounceInLeft"><td colspan="2">');
                            html.push('Updates are coming soon!');
                            html.push('</td></tr>');
                            html.push('</table>');
                            $("#activity-feed").html(html.join(""));
                        } else {
                            if (firstFeedLoad) {
                                $("#activity-feed").html(html.join(""));
                            } else {
                                $('#activity-feed-table > tbody > tr:first').before(html.join(""));
                                for (i = 0; i < addedRows; i++) {
                                    $('#activity-feed-table tr:last').remove();
                                }
                            }
                        }
                        feedLatest = newLatest;
                        if (firstFeedLoad) {
                            feedUpdateId = setInterval(loadFeed, 30 * 1000);
                            firstFeedLoad = false;
                        }
                    }
                }
            })
            .fail(function () {
                clearInterval(feedUpdateId);
            });
    }
</script>
