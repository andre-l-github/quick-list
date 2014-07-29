var Repository = function($service) {
  this.service = $service;

  this.query = function(fn) {
    this.service.query(fn);
  };

  this.get = function(id) {
    return this.service.get({ id: id });
  };

  this.create = function(attr) {
    return this.service.save({ list: attr });
  }
};
