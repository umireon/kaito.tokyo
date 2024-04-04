export const prerender = true;

import { getYouTubeVideoList } from "$lib/youtube/videos";
import type { PageServerLoad } from "./$types";

export const load = (async () => {
	const youtubeVideoList = await getYouTubeVideoList();
	youtubeVideoList.reverse();
	return {
		youtubeVideoList
	};
}) satisfies PageServerLoad;
