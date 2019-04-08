import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  int id;                               
  int sid;                             
  String token;     
  String phone;        
  String username;     
  int createTime;                       
  String avatar;                           
  int sex;                           
  String city;        
  int openBook;                      
  int bookQuantity;                  
  int libraryQuantity;               
  int clippingQuantity;              
  int friendQuantity;                
  int wantReadQuantity;              
  int haveReadQuantity;              
  int collectionQuantity;            
  int borrowedQuantity;              
  int borrowingQuantity;             
  int lentQuantity;                  
  int lendingQuantity;               
  int unreadMessageQuantity;         

  User(
    this.id,                               
    this.sid,                             
    this.token,     
    this.phone,        
    this.username,    
    this.createTime,                       
    this.avatar,                          
    this.sex,                          
    this.city,        
    this.openBook,                      
    this.bookQuantity,                  
    this.libraryQuantity,               
    this.clippingQuantity,              
    this.friendQuantity,                
    this.wantReadQuantity,              
    this.haveReadQuantity,              
    this.collectionQuantity,            
    this.borrowedQuantity,              
    this.borrowingQuantity,            
    this.lentQuantity,                 
    this.lendingQuantity,              
    this.unreadMessageQuantity, 
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
