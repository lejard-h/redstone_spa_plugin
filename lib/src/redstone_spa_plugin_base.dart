// Copyright (c) 2016, Hadrien Lejard. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import "dart:io";
import "package:path/path.dart" as Path;
import "package:mime/mime.dart" as Mime;
import "package:shelf/shelf.dart" as Shelf;
import "package:di/di.dart";
import "package:redstone/redstone.dart";

RedstonePlugin RedstoneSpaPlugin(String directory, [List<String> ignorePath]) => (Manager manager) {
      File _index = new File(Path.normalize("${Path.dirname(Path.fromUri(Platform.script))}/$directory/index.html"));
      manager.addErrorHandler(const ErrorHandler(404), "Redirect To Index", (Injector injector, Request request) {
        if (ignorePath != null && ignorePath.every((String path) => request.requestedUri.path.startsWith(path))) {
          return chain.next();
        }
        File req = new File("${Path.dirname(Path.fromUri(Platform.script))}/$directory/${request.requestedUri.path}");
        if (!req.existsSync()) {
          req = _index;
        }
        String contentType = Mime.lookupMimeType(req.path);
        return new Shelf.Response.ok(req.openRead(), headers: {HttpHeaders.CONTENT_TYPE: contentType});
      });
    };
