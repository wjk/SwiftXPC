//
//  XPCTypeShims.m
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

#import "SwiftXPCShims.h"

xpc_type_t XPCShimGetConnectionType(void) {
    return XPC_TYPE_CONNECTION;
}

xpc_type_t XPCShimGetEndpointType(void) {
    return XPC_TYPE_ENDPOINT;
}

xpc_type_t XPCShimGetActivityType(void) {
    return XPC_TYPE_ACTIVITY;
}

xpc_type_t XPCShimGetNullType(void) {
    return XPC_TYPE_NULL;
}

xpc_type_t XPCShimGetBooleanType(void) {
    return XPC_TYPE_BOOL;
}

xpc_type_t XPCShimGetInt64Type(void) {
    return XPC_TYPE_INT64;
}

xpc_type_t XPCShimGetUInt64Type(void) {
    return XPC_TYPE_UINT64;
}

xpc_type_t XPCShimGetDoubleType(void) {
    return XPC_TYPE_DOUBLE;
}

xpc_type_t XPCShimGetDateType(void) {
    return XPC_TYPE_DATE;
}

xpc_type_t XPCShimGetDataType(void) {
    return XPC_TYPE_DATA;
}

xpc_type_t XPCShimGetStringType(void) {
    return XPC_TYPE_STRING;
}

xpc_type_t XPCShimGetUUIDType(void) {
    return XPC_TYPE_UUID;
}

xpc_type_t XPCShimGetFileDescriptorType(void) {
    return XPC_TYPE_FD;
}

xpc_type_t XPCShimGetSharedMemoryType(void) {
    return XPC_TYPE_SHMEM;
}

xpc_type_t XPCShimGetArrayType(void) {
    return XPC_TYPE_ARRAY;
}

xpc_type_t XPCShimGetDictionaryType(void) {
    return XPC_TYPE_DICTIONARY;
}

xpc_type_t XPCShimGetErrorType(void) {
    return XPC_TYPE_ERROR;
}

xpc_object_t XPCShimGetConnectionInterruptedError(void) {
    return XPC_ERROR_CONNECTION_INTERRUPTED;
}

xpc_object_t XPCShimGetConnectionInvalidError(void) {
    return XPC_ERROR_CONNECTION_INVALID;
}

xpc_object_t XPCShimGetTerminationImminentError(void) {
    return XPC_ERROR_TERMINATION_IMMINENT;
}

xpc_object_t XPCShimCreateObjectFromUUID(NSUUID *uuid) {
    uuid_t bytes;
    [uuid getUUIDBytes:bytes];
    return xpc_uuid_create(bytes);
}

NSUUID *XPCShimGetUUIDFromObject(xpc_object_t object) {
    const unsigned char * bytes = xpc_uuid_get_bytes(object);
    return [[NSUUID alloc] initWithUUIDBytes:bytes];
}

unsigned char * XPCShimMapSharedMemoryRegion(xpc_object_t region, size_t *size) {
    unsigned char *ptr;
    size_t retval = xpc_shmem_map(region, (void **) &ptr);
    if (retval == 0) return NULL;
    
    if (size != NULL) *size = retval;
    return ptr;
}

static void (^swiftBlock)(xpc_connection_t connection) = NULL;
static void XPCShimConnectionHandler(xpc_connection_t connection) {
    if (swiftBlock != NULL) swiftBlock(connection);
}

void __attribute__((noreturn)) XPCShimMain(void (^block)(xpc_connection_t connection)) {
    swiftBlock = block;
    xpc_main(XPCShimConnectionHandler);
}
