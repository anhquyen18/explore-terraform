exports.handler = async (event, context, callback) => {
  const request = event.Records[0].cf.request;
  const headers = request.headers;

  if (headers.cookie) {
    for (let i = 0; i < headers.cookie.length; i++) {
      if (headers.cookie[i].value.indexOf("X-Redirect-Flag=Pro") >= 0) {
        request.origin = {
          s3: {
            authMethod: "origin-access-identity",
            domainName: "explore-terraform-s3-pro-aq.s3.amazonaws.com",
            region: "ap-southeast-1",
            path: "",
          },
        };

        headers["host"] = [
          {
            key: "host",
            value: "terraform-serries-s3-pro.s3.amazonaws.com",
          },
        ];
        break;
      }

      if (headers.cookie[i].value.indexOf("X-Redirect-Flag=Pre-Pro") >= 0) {
        request.origin = {
          s3: {
            authMethod: "origin-access-identity",
            domainName: "explore-terraform-s3-pre-pro-aq.s3.amazonaws.com",
            region: "ap-southeast-1",
            path: "",
          },
        };

        headers["host"] = [
          {
            key: "host",
            value: "explore-terraform-s3-pre-pro-aq.s3.amazonaws.com",
          },
        ];
        break;
      }
    }
  }

  callback(null, request);
};
