var Repository = function($service) {
  this.service = $service;

  this.query = function(fn) {
    this.service.query(fn);
  };

  this.get = function(id) {
    return this.service.get({ id: id });
  };

  this.destroy = function(id, success, error) {
    this.service.remove({ id: id }, success, error);
  }

  this.create = function(attr) {
    return this.service.save({ list: attr });
  }
};
