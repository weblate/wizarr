export interface Server {
    settings: ServerSettings;
    version: string;
    update_available: boolean;
    debug: boolean;
    setup_required: boolean;
}

export interface ServerSettings {
    server_name: string;
    server_url: string;
    server_type: "jellyfin" | "plex";
    server_verified: string;
}
