import 'dart:convert';

SeriesResponse seriesResponseFromJson(String str) => SeriesResponse.fromJson(json.decode(str));

String seriesResponseToJson(SeriesResponse data) => json.encode(data.toJson());

class SeriesResponse {
    int code;
    String status;
    String copyright;
    String attributionText;
    String attributionHtml;
    String etag;
    Data data;

    SeriesResponse({
        this.code,
        this.status,
        this.copyright,
        this.attributionText,
        this.attributionHtml,
        this.etag,
        this.data,
    });

    factory SeriesResponse.fromJson(Map<String, dynamic> json) => SeriesResponse(
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
    int startYear;
    int endYear;
    String rating;
    ResultType type;
    String modified;
    Thumbnail thumbnail;
    Creators creators;
    Characters characters;
    Stories stories;
    Comics comics;
    Characters events;
    Next next;
    dynamic previous;

    Result({
        this.id,
        this.title,
        this.description,
        this.resourceUri,
        this.urls,
        this.startYear,
        this.endYear,
        this.rating,
        this.type,
        this.modified,
        this.thumbnail,
        this.creators,
        this.characters,
        this.stories,
        this.comics,
        this.events,
        this.next,
        this.previous,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        description: json["description"] == null ? null : json["description"],
        resourceUri: json["resourceURI"],
        urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
        startYear: json["startYear"],
        endYear: json["endYear"],
        rating: json["rating"],
        type: resultTypeValues.map[json["type"]],
        modified: json["modified"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        creators: Creators.fromJson(json["creators"]),
        characters: Characters.fromJson(json["characters"]),
        stories: Stories.fromJson(json["stories"]),
        comics: Comics.fromJson(json["comics"]),
        events: Characters.fromJson(json["events"]),
        next: json["next"] == null ? null : Next.fromJson(json["next"]),
        previous: json["previous"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description == null ? null : description,
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
        "startYear": startYear,
        "endYear": endYear,
        "rating": rating,
        "type": resultTypeValues.reverse[type],
        "modified": modified,
        "thumbnail": thumbnail.toJson(),
        "creators": creators.toJson(),
        "characters": characters.toJson(),
        "stories": stories.toJson(),
        "comics": comics.toJson(),
        "events": events.toJson(),
        "next": next == null ? null : next.toJson(),
        "previous": previous,
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

enum Role { PENCILER, INKER, PENCILER_COVER, EDITOR, COLORIST_COVER, WRITER, PENCILLER_COVER, PENCILLER, ARTIST, LETTERER, INKER_COVER, COLORIST, PAINTER_COVER }

final roleValues = EnumValues({
    "artist": Role.ARTIST,
    "colorist": Role.COLORIST,
    "colorist (cover)": Role.COLORIST_COVER,
    "editor": Role.EDITOR,
    "inker": Role.INKER,
    "inker (cover)": Role.INKER_COVER,
    "letterer": Role.LETTERER,
    "painter (cover)": Role.PAINTER_COVER,
    "penciler": Role.PENCILER,
    "penciler (cover)": Role.PENCILER_COVER,
    "penciller": Role.PENCILLER,
    "penciller (cover)": Role.PENCILLER_COVER,
    "writer": Role.WRITER
});


class Comics {
    int available;
    String collectionUri;
    List<ComicsItem> items;
    int returned;

    Comics({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    factory Comics.fromJson(Map<String, dynamic> json) => Comics(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<ComicsItem>.from(json["items"].map((x) => ComicsItem.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class ComicsItem {
    String resourceUri;
    String name;

    ComicsItem({
        this.resourceUri,
        this.name,
    });

    factory ComicsItem.fromJson(Map<String, dynamic> json) => ComicsItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
    };
}

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

enum ItemType { COVER, INTERIOR_STORY }

final itemTypeValues = EnumValues({
    "cover": ItemType.COVER,
    "interiorStory": ItemType.INTERIOR_STORY
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

enum ResultType { ONE_SHOT, LIMITED, EMPTY, ONGOING }

final resultTypeValues = EnumValues({
    "": ResultType.EMPTY,
    "limited": ResultType.LIMITED,
    "one shot": ResultType.ONE_SHOT,
    "ongoing": ResultType.ONGOING
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

enum UrlType { DETAIL }

final urlTypeValues = EnumValues({
    "detail": UrlType.DETAIL
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