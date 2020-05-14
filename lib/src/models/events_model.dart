// To parse this JSON data, do
//
//     final eventsResponse = eventsResponseFromJson(jsonString);

import 'dart:convert';

EventsResponse eventsResponseFromJson(String str) => EventsResponse.fromJson(json.decode(str));

String eventsResponseToJson(EventsResponse data) => json.encode(data.toJson());

class EventsResponse {
    int code;
    String status;
    String copyright;
    String attributionText;
    String attributionHtml;
    String etag;
    Data data;

    EventsResponse({
        this.code,
        this.status,
        this.copyright,
        this.attributionText,
        this.attributionHtml,
        this.etag,
        this.data,
    });

    factory EventsResponse.fromJson(Map<String, dynamic> json) => EventsResponse(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data.toJson(),
    };
}

class Data {
    int offset;
    int limit;
    int total;
    int count;
    List<Result> results;

    Data({
        this.offset,
        this.limit,
        this.total,
        this.count,
        this.results,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    int id;
    String title;
    String description;
    String resourceUri;
    List<Url> urls;
    String modified;
    DateTime start;
    DateTime end;
    Thumbnail thumbnail;
    Creators creators;
    Characters characters;
    Stories stories;
    Characters comics;
    Characters series;
    Next next;
    Next previous;

    Result({
        this.id,
        this.title,
        this.description,
        this.resourceUri,
        this.urls,
        this.modified,
        this.start,
        this.end,
        this.thumbnail,
        this.creators,
        this.characters,
        this.stories,
        this.comics,
        this.series,
        this.next,
        this.previous,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        resourceUri: json["resourceURI"],
        urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
        modified: json["modified"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        creators: Creators.fromJson(json["creators"]),
        characters: Characters.fromJson(json["characters"]),
        stories: Stories.fromJson(json["stories"]),
        comics: Characters.fromJson(json["comics"]),
        series: Characters.fromJson(json["series"]),
        next: json["next"] == null ? null : Next.fromJson(json["next"]),
        previous: json["previous"] == null ? null : Next.fromJson(json["previous"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
        "modified": modified,
        "start": start == null ? null : start.toIso8601String(),
        "end": end == null ? null : end.toIso8601String(),
        "thumbnail": thumbnail.toJson(),
        "creators": creators.toJson(),
        "characters": characters.toJson(),
        "stories": stories.toJson(),
        "comics": comics.toJson(),
        "series": series.toJson(),
        "next": next == null ? null : next.toJson(),
        "previous": previous == null ? null : previous.toJson(),
    };
}

class Characters {
    int available;
    String collectionUri;
    List<Next> items;
    int returned;

    Characters({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<Next>.from(json["items"].map((x) => Next.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class Next {
    String resourceUri;
    String name;

    Next({
        this.resourceUri,
        this.name,
    });

    factory Next.fromJson(Map<String, dynamic> json) => Next(
        resourceUri: json["resourceURI"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
    };
}

class Creators {
    int available;
    String collectionUri;
    List<CreatorsItem> items;
    int returned;

    Creators({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    factory Creators.fromJson(Map<String, dynamic> json) => Creators(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<CreatorsItem>.from(json["items"].map((x) => CreatorsItem.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class CreatorsItem {
    String resourceUri;
    String name;
    Role role;

    CreatorsItem({
        this.resourceUri,
        this.name,
        this.role,
    });

    factory CreatorsItem.fromJson(Map<String, dynamic> json) => CreatorsItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        role: roleValues.map[json["role"]],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "role": roleValues.reverse[role],
    };
}

enum Role { INKER, PENCILER, WRITER, COLORIST, LETTERER, PENCILLER_COVER, PENCILLER, EDITOR, PENCILER_COVER, ARTIST, ROLE_COLORIST, ROLE_PENCILLER, ROLE_LETTERER, COLORIST_COVER, OTHER, INKER_COVER }

final roleValues = EnumValues({
    "artist": Role.ARTIST,
    "colorist": Role.COLORIST,
    "colorist (cover)": Role.COLORIST_COVER,
    "editor": Role.EDITOR,
    "inker": Role.INKER,
    "inker (cover)": Role.INKER_COVER,
    "letterer": Role.LETTERER,
    "other": Role.OTHER,
    "penciler": Role.PENCILER,
    "penciler (cover)": Role.PENCILER_COVER,
    "penciller": Role.PENCILLER,
    "penciller (cover)": Role.PENCILLER_COVER,
    "Colorist": Role.ROLE_COLORIST,
    "Letterer": Role.ROLE_LETTERER,
    "Penciller": Role.ROLE_PENCILLER,
    "writer": Role.WRITER
});

class Stories {
    int available;
    String collectionUri;
    List<StoriesItem> items;
    int returned;

    Stories({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class StoriesItem {
    String resourceUri;
    String name;
    ItemType type;

    StoriesItem({
        this.resourceUri,
        this.name,
        this.type,
    });

    factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        type: itemTypeValues.map[json["type"]],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "type": itemTypeValues.reverse[type],
    };
}

enum ItemType { COVER, INTERIOR_STORY, EMPTY, TEXT_ARTICLE, TABLE_OF_CONTENTS, PINUP, CREDITS, PROMO }

final itemTypeValues = EnumValues({
    "cover": ItemType.COVER,
    "credits": ItemType.CREDITS,
    "": ItemType.EMPTY,
    "interiorStory": ItemType.INTERIOR_STORY,
    "pinup": ItemType.PINUP,
    "promo": ItemType.PROMO,
    "table of contents": ItemType.TABLE_OF_CONTENTS,
    "text article": ItemType.TEXT_ARTICLE
});

class Thumbnail {
    String path;
    Extension extension;

    Thumbnail({
        this.path,
        this.extension,
    });

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: extensionValues.map[json["extension"]],
    );

    Map<String, dynamic> toJson() => {
        "path": path,
        "extension": extensionValues.reverse[extension],
    };
}

enum Extension { JPG }

final extensionValues = EnumValues({
    "jpg": Extension.JPG
});

class Url {
    UrlType type;
    String url;

    Url({
        this.type,
        this.url,
    });

    factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: urlTypeValues.map[json["type"]],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "type": urlTypeValues.reverse[type],
        "url": url,
    };
}

enum UrlType { DETAIL, WIKI }

final urlTypeValues = EnumValues({
    "detail": UrlType.DETAIL,
    "wiki": UrlType.WIKI
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
