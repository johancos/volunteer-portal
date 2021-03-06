<%@ page import="org.springframework.context.i18n.LocaleContextHolder" contentType="text/html; charset=UTF-8" %>
%{-- include CSS and JS assets in calling page --}%
<g:set var="instName" value="${institutionName ?: institutionInstance?.i18nName ?: message(code: 'default.application.name')}"/>
<g:set var="institutionId" value="${institutionInstance?.id}"/>
<section id="digivol-stats" ng-app="stats" ng-controller="StatsCtrl" class="ng-cloak">
    <g:if test="${!disableStats}">
    <div class="panel panel-default volunteer-stats">
        <!-- Default panel contents -->
        <h2 class="heading"><g:message code="leaderBoard.stats.title" args="${[instName]}"/><g:link controller="user" action="list" class="pull-right"><i class="fa fa-users fa-sm"></i></g:link></h2>

        <h3>
            <g:link controller="user" action="list">
                <span data-ng-if="loading"><cl:spinner/></span>
                <span data-ng-if="!loading">{{transcriberCount}}</span>
                <g:message code="leaderboard.stats.volunteers" />
            </g:link>
        </h3>

        <p>
            <span data-ng-if="loading"><cl:spinner/></span>
            <span data-ng-if="!loading">{{completedTasks}}</span>
            <g:message code="leaderboard.stats.task_of" />
            <span data-ng-if="loading"><cl:spinner/></span>
            <span data-ng-if="!loading">{{totalTasks}}</span>
            <g:message code="leaderboard.stats.completed" />
        </p>

    </div><!-- Volunteer Stats Ends Here -->
    </g:if>
    <g:if test="${!disableHonourBoard}">
    <div class="panel panel-default leaderboard">
        <!-- Default panel contents -->
        <h2 class="heading"><g:message code="honour.board.label" /> <g:link controller="leaderBoard" action="describeBadges" class="pull-right"><i class="fa fa-trophy fa-sm"></i></g:link></h2>
        <!-- Table -->
        <table class="table">
            <thead>
            <tr>
                <th colspan="2"><g:message code="daily.leader.label" /></th>
                <th class="view-more"><g:link controller="leaderBoard" action="topList"
                                              params="[category: 'daily', institutionId: institutionId]"><g:message code="leaderboard.viewTop20.label" /></g:link></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row">
                    <a id="day-tripper-image" data-ng-href="{{userProfileUrl(daily)}}">
                        <img data-ng-src="{{avatarUrl(daily)}}" class="avatar img-circle">
                    </a>
                </th>
                <th>
                    <span data-ng-if="loading"><cl:spinner/></span>
                    <span data-ng-if="!loading">
                    <a id="day-tripper-name" data-ng-href="{{userProfileUrl(daily)}}">{{daily.name}}</a>
                    </span>
                </th>
                <td id="day-tripper-amount" class="transcribed-amount">{{daily.score}}</td>
            </tr>
            </tbody>
            <thead>
            <tr>
                <th colspan="2"><g:message code="weekly.leader.label" /></th>
                <th class="view-more"><g:link controller="leaderBoard" action="topList"
                                              params="[category: 'weekly', institutionId: institutionId]"><g:message code="leaderboard.viewTop20.label" /></g:link></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row">
                    <a id="weekly-wonder-image" data-ng-href="{{userProfileUrl(weekly)}}">
                        <img data-ng-src="{{avatarUrl(weekly)}}" class="avatar img-circle">
                    </a>
                </th>
                <th>
                    <span data-ng-if="loading"><cl:spinner/></span>
                    <span data-ng-if="!loading">
                    <a id="weekly-wonder-name" data-ng-href="{{userProfileUrl(weekly)}}">{{weekly.name}}</a>
                    </span>
                </th>
                <td id="weekly-wonder-amount" class="transcribed-amount">{{weekly.score}}</td>
            </tr>
            </tbody>
            <thead>
            <tr>
                <th colspan="2"><g:message code="monthly.leader.label" /></th>
                <th class="view-more"><g:link controller="leaderBoard" action="topList"
                                              params="[category: 'monthly', institutionId: institutionId]"><g:message code="leaderboard.viewTop20.label" /></g:link></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row">
                    <a id="monthly-maestro-image" data-ng-href="{{userProfileUrl(monthly)}}">
                        <img data-ng-src="{{avatarUrl(monthly)}}" class="avatar img-circle">
                    </a>
                </th>
                <th>
                    <span data-ng-if="loading"><cl:spinner/></span>
                    <span data-ng-if="!loading">
                    <a id="monthly-maestro-name"
                       data-ng-href="{{userProfileUrl(monthly)}}">{{monthly.name}}</a>
                    </span>
                </th>
                <td id="monthly-maestro-amount" class="transcribed-amount">{{monthly.score}}</td>
            </tr>
            </tbody>
            <thead>
            <tr>
                <th colspan="2">${instName} <g:message code="alltime.leader.label" /></th>
                <th class="view-more"><g:link controller="leaderBoard" action="topList"
                                              params="[category: 'alltime', institutionId: institutionId]"><g:message code="leaderboard.viewTop20.label" /></g:link></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row">
                    <a id="digivol-legend-image" data-ng-href="{{userProfileUrl(alltime)}}">
                        <img data-ng-src="{{avatarUrl(alltime)}}" class="avatar img-circle">
                    </a>
                </th>
                <th>
                    <span data-ng-if="loading"><cl:spinner/></span>
                    <span data-ng-if="!loading">
                    <a id="digivol-legend-name"
                       data-ng-href="{{userProfileUrl(alltime)}}">{{alltime.name}}</a>
                    </span>
                </th>
                <td id="digivol-legend-amount" class="transcribed-amount">{{alltime.score}}</td>
            </tr>
            </tbody>
        </table>
    </div><!-- Honour Board Ends Here -->
    </g:if>

    <h2 class="heading">
        <g:message code="latest.contributions.label" /><span data-ng-if="loading"> <cl:spinner/></span>
    </h2>
    <ul class="media-list"
        data-ng-repeat="contributor in contributors"
        data-ng-switch="contributor.type">
        %{-- Begin template for task transcription contribution --}%
        <li data-ng-switch-when="task" class="media">
            <div class="media-left">
                <a data-ng-href="{{userProfileUrl(contributor)}}">
                    <img data-ng-src="{{avatarUrl(contributor)}}" class="avatar img-circle">
                </a>
            </div>

            <div class="media-body">
                <span class="time" data-livestamp="{{contributor.timestamp}}"></span>
                <h4 class="media-heading"><a data-ng-href="{{userProfileUrl(contributor)}}">{{contributor.displayName}}</a></h4>

                <p>
                    <g:message code="leaderboard.stats.transcribed.prefix" />
                    <span>{{contributor.transcribedItems}}</span>
                    <g:message code="leaderboard.stats.transcribed.items_from_the" />
                    <a data-ng-href="{{projectUrl(contributor)}}">{{contributor.projectName}}</a>
                    <g:message code="leaderboard.stats.transcribed.sufix" />
                </p>

                <div class="transcribed-thumbs">
                    <img data-ng-repeat="thumb in contributor.transcribedThumbs" data-ng-src="{{thumb.thumbnailUrl}}">
                    <a data-ng-if="additionalTranscribedThumbs(contributor) > 0" data-ng-href="{{userProfileUrl(contributor)}}"><span>+{{additionalTranscribedThumbs(contributor)}}</span><g:message code="project.read_more" /></a>
                </div>
                <a class="btn btn-link btn-xs join" role="button"
                   data-ng-href="{{projectUrl(contributor)}}"><g:message code="join.expedition.label" /> »</a>
            </div>
        </li>
        %{-- Begin template for forum message contribution --}%
        <li data-ng-switch-when="forum" class="media">
            <div class="media-left">
                <a data-ng-href="{{userProfileUrl(contributor)}}">
                    <img data-ng-src="{{avatarUrl(contributor)}}" class="avatar img-circle">
                </a>
            </div>
            <div class="media-body">
                <span class="time" data-livestamp="{{contributor.timestamp}}"></span>
                <h4 class="media-heading"><a data-ng-href="{{userProfileUrl(contributor)}}">{{contributor.displayName}}</a></h4>
                <p><g:message code="leaderboard.stats.has_posted_in_the_forum" />: <a data-ng-href="{{contributor.forumUrl}}">{{contributor.forumName}}</a></p>
                <div class="transcribed-thumbs">
                    <img data-ng-src="{{contributor.thumbnailUrl}}">
                </div>
                <a class="btn btn-link btn-xs join" data-ng-href="{{contributor.topicUrl}}" role="button"><g:message code="join.discussion.label" /> »</a>
            </div>
        </li>
    </ul>
    <g:link controller="user" action="list"><g:message code="view.all.contributors.label" /> »</g:link>
</section>
<asset:javascript src="digivol-stats.js" asset-defer=""/>
<asset:script>

    moment.locale("${ LocaleContextHolder.getLocale().getLanguage()}");  // Set the default/global locale

  digivolStats({
  statsUrl: "${createLink(controller: 'index', action: 'stats')}",
projectUrl: "${createLink(controller: 'project', action: 'index', id: -1)}",
userProfileUrl: "${createLink(controller: 'user', action: 'show', id: -1)}",
taskSummaryUrl: "${createLink(controller: 'task', action: 'summary', id: -1)}",
institutionId: ${institutionId ?: -1},
projectId: ${projectId ?: -1},
maxContributors: ${maxContributors ?: 5},
disableStats: ${disableStats ? 'true' : 'false' },
disableHonourBoard: ${disableHonourBoard ? 'true' : 'false' },
    });
</asset:script>