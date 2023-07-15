import ballerina/http;


type Project readonly & record {|
   int? id;
   string name;
   string description;
   string imageUrl;
   int contractTypeId;
   string contractSignedOn;
   int budget;
   boolean isActive;


|};

table<Project> key(id) projects = table [
   {id: 1,
    name: "Johnson - Kutch",
    description:"Fully-configurable intermediate framework. Ullam occaecati libero laudantium nihil voluptas omnis.",
    imageUrl: "/assets/placeimg_500_300_arch4.jpg",
    contractTypeId: 3,
    contractSignedOn: "2013-08-04T22:39:41.473Z",
    budget: 54637,
    isActive: false
  },
  {
    id: 2,
    name: "Wisozk Group",
    description:"Centralized interactive application. Exercitationem nulla ut ipsam vero quasi enim quos doloribus voluptatibus.",
    imageUrl: "/assets/placeimg_500_300_arch1.jpg",
    contractTypeId: 4,
    contractSignedOn: "2012-08-06T21:21:31.419Z",
    budget: 91638,
    isActive: true
  },
  {
    id: 3,
    name: "Denesik LLC",
    description:
      "Re-contextualized dynamic moratorium. Aut nulla soluta numquam qui dolor architecto et facere dolores.",
    imageUrl: "/assets/placeimg_500_300_arch12.jpg",
    contractTypeId: 6,
    contractSignedOn: "2016-06-26T18:24:01.706Z",
    budget: 29729,
    isActive: true
  },
  {
    id: 4,
    name: "Purdy, Keeling and Smitham",
    description:
      "Innovative 6th generation model. Perferendis libero qui iusto et ullam cum sint molestias vel.",
    imageUrl: "/assets/placeimg_500_300_arch5.jpg",
    contractTypeId: 4,
    contractSignedOn: "2013-05-26T01:10:42.344Z",
    budget: 45660,
    isActive: true
  }


];

service / on new http:Listener(9090) {

    resource function get projects() returns Project[] {
        return projects.toArray();
    }

      resource function put projects(@http:Payload Project project) returns Project| error {
        if project.id is () || !projects.hasKey(project.id) {
            return  error("Invalid project provided for update");
        }
        _=projects.remove(project.id);
        projects.add(project);

        return  projects.get(project.id);

    }

  
}
