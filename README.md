# Cache Manager Flutter
Cache Manager using GetStorage with time expiration

## Used Packages

To use this file, you need to be using:

- [GetX](https://pub.dev/packages/get)
- [Get Storage](https://pub.dev/packages/get_storage)

So, to add them to the project, you just need to run:

```
flutter pub add get
```

and

```
flutter pub add get_storage
```

## Example

### You need to save some data for some time

To use, you just have to declare the class like this:

```
class ...Manager extends GetxController with CacheManager { 

}
```

and then, when you need, just call the function you need:

#### Save
```
saveValue(value, CacheManagerKey.userToken)
```

#### Get a value by key
```
getValueFrom(CacheManagerKey.userToken) 
```

#### Remove value by key

```
removeValueFrom(CacheManagerKey.userToken)
```

#### Remove all cached data

```
removeAllCacheData()
```

#### Check if it is expired
```
isValid(ExpirationTime.inDays, 3, savedValue.lastSaved)
```