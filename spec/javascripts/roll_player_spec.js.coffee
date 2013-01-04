describe "RollPlayer", ->
    json_response = null

    beforeEach ->
        loadFixtures 'baz'

        json_response =
            apiVersion: "2.1"
            data:
                updated: "2013-01-02T17:24:58.612Z"
                totalItems: 1
                startIndex: 1
                itemsPerPage: 1
                items: [
                    id: "ES-Y5XBKDNc"
                    uploaded: "2010-09-01T10:32:07.000Z"
                    updated: "2012-11-16T13:43:25.000Z"
                    uploader: "space4keys"
                    category: "Music"
                    title: "S4K FREE Piano Collection on Korg Oasys / M3 by Space4keys ( Kurzweil Yamaha Roland )"
                    description: "Inspired by great piano sounds - features: St.Way Piano - Kurzy Piano - Triple K. Piano - Triple + Choir-String - Yamay Piano - Korgy Rock Piano - Clavy Piano - Rolly + Choir-String - Detuned Piano + BONUS pianos Patched by S4K Team Performed by Sion www.space4keys.com http"
                    thumbnail:
                        sqDefault: "http://i.ytimg.com/vi/ES-Y5XBKDNc/default.jpg"
                        hqDefault: "http://i.ytimg.com/vi/ES-Y5XBKDNc/hqdefault.jpg"

                    player:
                        default: "http://www.youtube.com/watch?v=ES-Y5XBKDNc&feature=youtube_gdata_player"
                        mobile: "http://m.youtube.com/details?v=ES-Y5XBKDNc"

                    content:
                        5: "http://www.youtube.com/v/ES-Y5XBKDNc?version=3&f=videos&app=youtube_gdata"
                        1: "rtsp://v5.cache6.c.youtube.com/CiILENy73wIaGQnXDEpw5ZgvERMYDSANFEgGUgZ2aWRlb3MM/0/0/0/video.3gp"
                        6: "rtsp://v5.cache6.c.youtube.com/CiILENy73wIaGQnXDEpw5ZgvERMYESARFEgGUgZ2aWRlb3MM/0/0/0/video.3gp"

                    duration: 450
                    aspectRatio: "widescreen"
                    rating: 4.9148936
                    likeCount: "46"
                    ratingCount: 47
                    viewCount: 24016
                    favoriteCount: 0
                    commentCount: 28
                    accessControl:
                        comment: "allowed"
                        commentVote: "allowed"
                        videoRespond: "moderated"
                        rate: "allowed"
                        embed: "allowed"
                        list: "allowed"
                        autoPlay: "allowed"
                        syndicate: "allowed"
                ]


    it "parses valid video ID from youtube url", ->
        player = new RollPlayer(
            youtube_url: "http://www.youtube.com/watch?v=ES-Y5XBKDNc"
            container_element: "player"
            player_id: "ytPlayer"
        )
        
        expect(player.youtubeID).toBe("ES-Y5XBKDNc")

    it "throws exception on invalid url", ->
        # expect((new RollPlayer("http://wwe.com/watch?v=ESBKDNc")).toThrow(new Error("invalid url")))

    it "should successful set youtube_id and duration through ajax calls", ->
        spyOn($, "getJSON").andCallFake (url, callback) ->
            callback json_response

        player = new RollPlayer(
            youtube_url: "http://www.youtube.com/watch?v=ES-Y5XBKDNc"
            container_element: "player"
            player_id: "ytPlayer"
        )
    
        expect(player.duration).toBe(450)        

    it "loads swf object into the HTML document on creation", ->
        loadFixtures 'baz'
        isReady = false
        player = new RollPlayer(
            youtube_url: "http://www.youtube.com/watch?v=ES-Y5XBKDNc"
            container_element: "player"
            player_id: "ytPlayer",
            => isReady = true
        )

        # Checks that SWF object loaded
        # expect($('#ytPlayer').prop('tagName')).toBe('OBJECT')
        # expect($('#ytPlayer').prop('type')).toBe('application/x-shockwave-flash')
            
        waitsFor (->
            isReady
        ), "YouTube player never loaded", 1000

        # playState = player.getPlayerState()
        # expect(playState).toBe(-2)







