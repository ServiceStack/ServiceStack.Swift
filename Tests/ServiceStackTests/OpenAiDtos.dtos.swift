/* Options:
Date: 2024-11-25 09:52:37
SwiftVersion: 6.0
Version: 8.41
Tip: To override a DTO option, remove "//" prefix before updating
BaseUrl: https://openai.servicestack.net

//BaseClass: 
//AddModelExtensions: True
//AddServiceStackTypes: True
//MakePropertiesOptional: True
IncludeTypes: OpenAiChatCompletion.*,ToolCall,SpeechToText.*
//ExcludeTypes: 
//ExcludeGenericBaseTypes: False
//AddResponseStatus: False
//AddImplicitVersion: 
//AddDescriptionAsComments: True
//InitializeCollections: False
//TreatTypesAsStrings: 
//DefaultImports: Foundation,ServiceStack
*/

import Foundation
import ServiceStack

/**
* Given a list of messages comprising a conversation, the model will return a response.
*/
// @Route("/v1/chat/completions", "POST")
// @Api(Description="Given a list of messages comprising a conversation, the model will return a response.")
public class OpenAiChatCompletion : OpenAiChat, IReturn, IPost
{
    public typealias Return = OpenAiChatResponse

    /**
    * Provide a unique identifier to track requests
    */
    // @ApiMember(Description="Provide a unique identifier to track requests")
    public var refId:String?

    /**
    * Specify which AI Provider to use
    */
    // @ApiMember(Description="Specify which AI Provider to use")
    public var provider:String?

    /**
    * Categorize like requests under a common group
    */
    // @ApiMember(Description="Categorize like requests under a common group")
    public var tag:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case refId
        case provider
        case tag
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        refId = try container.decodeIfPresent(String.self, forKey: .refId)
        provider = try container.decodeIfPresent(String.self, forKey: .provider)
        tag = try container.decodeIfPresent(String.self, forKey: .tag)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if refId != nil { try container.encode(refId, forKey: .refId) }
        if provider != nil { try container.encode(provider, forKey: .provider) }
        if tag != nil { try container.encode(tag, forKey: .tag) }
    }
}

/**
* Convert speech to text
*/
// @Api(Description="Convert speech to text")
public class SpeechToText : IReturn, IGeneration, Codable
{
    public typealias Return = TextGenerationResponse

    /**
    * The audio stream containing the speech to be transcribed
    */
    // @ApiMember(Description="The audio stream containing the speech to be transcribed")
    // @Required()
    public var audio:String?

    /**
    * Optional client-provided identifier for the request
    */
    // @ApiMember(Description="Optional client-provided identifier for the request")
    public var refId:String?

    /**
    * Tag to identify the request
    */
    // @ApiMember(Description="Tag to identify the request")
    public var tag:String?

    required public init(){}
}

// @DataContract
public class OpenAiChatResponse : Codable
{
    /**
    * A unique identifier for the chat completion.
    */
    // @DataMember(Name="id")
    // @ApiMember(Description="A unique identifier for the chat completion.")
    public var id:String?

    /**
    * A list of chat completion choices. Can be more than one if n is greater than 1.
    */
    // @DataMember(Name="choices")
    // @ApiMember(Description="A list of chat completion choices. Can be more than one if n is greater than 1.")
    public var choices:[Choice] = []

    /**
    * The Unix timestamp (in seconds) of when the chat completion was created.
    */
    // @DataMember(Name="created")
    // @ApiMember(Description="The Unix timestamp (in seconds) of when the chat completion was created.")
    public var created:Int?

    /**
    * The model used for the chat completion.
    */
    // @DataMember(Name="model")
    // @ApiMember(Description="The model used for the chat completion.")
    public var model:String?

    /**
    * This fingerprint represents the backend configuration that the model runs with.
    */
    // @DataMember(Name="system_fingerprint")
    // @ApiMember(Description="This fingerprint represents the backend configuration that the model runs with.")
    public var system_fingerprint:String?

    /**
    * The object type, which is always chat.completion.
    */
    // @DataMember(Name="object")
    // @ApiMember(Description="The object type, which is always chat.completion.")
    public var object:String?

    /**
    * Usage statistics for the completion request.
    */
    // @DataMember(Name="usage")
    // @ApiMember(Description="Usage statistics for the completion request.")
    public var usage:OpenAiUsage?

    // @DataMember(Name="responseStatus")
    public var responseStatus:ResponseStatus?

    required public init(){}
}

/**
* Response object for text generation requests
*/
// @Api(Description="Response object for text generation requests")
public class TextGenerationResponse : Codable
{
    /**
    * List of generated text outputs
    */
    // @ApiMember(Description="List of generated text outputs")
    public var results:[TextOutput]?

    /**
    * Detailed response status information
    */
    // @ApiMember(Description="Detailed response status information")
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public protocol IGeneration
{
    var refId:String? { get set }
    var tag:String? { get set }

}

/**
* A list of messages comprising the conversation so far.
*/
// @Api(Description="A list of messages comprising the conversation so far.")
// @DataContract
public class OpenAiMessage : Codable
{
    /**
    * The contents of the message.
    */
    // @DataMember(Name="content")
    // @ApiMember(Description="The contents of the message.")
    public var content:String?

    /**
    * The role of the author of this message. Valid values are `system`, `user`, `assistant` and `tool`.
    */
    // @DataMember(Name="role")
    // @ApiMember(Description="The role of the author of this message. Valid values are `system`, `user`, `assistant` and `tool`.")
    public var role:String?

    /**
    * An optional name for the participant. Provides the model information to differentiate between participants of the same role.
    */
    // @DataMember(Name="name")
    // @ApiMember(Description="An optional name for the participant. Provides the model information to differentiate between participants of the same role.")
    public var name:String?

    /**
    * The tool calls generated by the model, such as function calls.
    */
    // @DataMember(Name="tool_calls")
    // @ApiMember(Description="The tool calls generated by the model, such as function calls.")
    public var tool_calls:[ToolCall]?

    /**
    * Tool call that this message is responding to.
    */
    // @DataMember(Name="tool_call_id")
    // @ApiMember(Description="Tool call that this message is responding to.")
    public var tool_call_id:String?

    required public init(){}
}

// @DataContract
public class OpenAiResponseFormat : Codable
{
    /**
    * An object specifying the format that the model must output. Compatible with GPT-4 Turbo and all GPT-3.5 Turbo models newer than gpt-3.5-turbo-1106.
    */
    // @DataMember(Name="response_format")
    // @ApiMember(Description="An object specifying the format that the model must output. Compatible with GPT-4 Turbo and all GPT-3.5 Turbo models newer than gpt-3.5-turbo-1106.")
    public var response_format:ResponseFormat?

    required public init(){}
}

// @DataContract
public class OpenAiTools : Codable
{
    /**
    * The type of the tool. Currently, only function is supported.
    */
    // @DataMember(Name="type")
    // @ApiMember(Description="The type of the tool. Currently, only function is supported.")
    public var type:OpenAiToolType?

    required public init(){}
}

/**
* Given a list of messages comprising a conversation, the model will return a response.
*/
// @Api(Description="Given a list of messages comprising a conversation, the model will return a response.")
// @DataContract
public class OpenAiChat : Codable
{
    /**
    * A list of messages comprising the conversation so far.
    */
    // @DataMember(Name="messages")
    // @ApiMember(Description="A list of messages comprising the conversation so far.")
    public var messages:[OpenAiMessage] = []

    /**
    * ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API
    */
    // @DataMember(Name="model")
    // @ApiMember(Description="ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API")
    public var model:String?

    /**
    * Number between `-2.0` and `2.0`. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
    */
    // @DataMember(Name="frequency_penalty")
    // @ApiMember(Description="Number between `-2.0` and `2.0`. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.")
    public var frequency_penalty:Double?

    /**
    * Modify the likelihood of specified tokens appearing in the completion.
    */
    // @DataMember(Name="logit_bias")
    // @ApiMember(Description="Modify the likelihood of specified tokens appearing in the completion.")
    public var logit_bias:[Int:Int]?

    /**
    * Whether to return log probabilities of the output tokens or not. If true, returns the log probabilities of each output token returned in the content of message.
    */
    // @DataMember(Name="logprobs")
    // @ApiMember(Description="Whether to return log probabilities of the output tokens or not. If true, returns the log probabilities of each output token returned in the content of message.")
    public var logprobs:Bool?

    /**
    * An integer between 0 and 20 specifying the number of most likely tokens to return at each token position, each with an associated log probability. logprobs must be set to true if this parameter is used.
    */
    // @DataMember(Name="top_logprobs")
    // @ApiMember(Description="An integer between 0 and 20 specifying the number of most likely tokens to return at each token position, each with an associated log probability. logprobs must be set to true if this parameter is used.")
    public var top_logprobs:Int?

    /**
    * The maximum number of tokens that can be generated in the chat completion.
    */
    // @DataMember(Name="max_tokens")
    // @ApiMember(Description="The maximum number of tokens that can be generated in the chat completion.")
    public var max_tokens:Int?

    /**
    * How many chat completion choices to generate for each input message. Note that you will be charged based on the number of generated tokens across all of the choices. Keep `n` as `1` to minimize costs.
    */
    // @DataMember(Name="n")
    // @ApiMember(Description="How many chat completion choices to generate for each input message. Note that you will be charged based on the number of generated tokens across all of the choices. Keep `n` as `1` to minimize costs.")
    public var n:Int?

    /**
    * Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
    */
    // @DataMember(Name="presence_penalty")
    // @ApiMember(Description="Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.")
    public var presence_penalty:Double?

    /**
    * An object specifying the format that the model must output. Compatible with GPT-4 Turbo and all GPT-3.5 Turbo models newer than `gpt-3.5-turbo-1106`. Setting Type to ResponseFormat.JsonObject enables JSON mode, which guarantees the message the model generates is valid JSON.
    */
    // @DataMember(Name="response_format")
    // @ApiMember(Description="An object specifying the format that the model must output. Compatible with GPT-4 Turbo and all GPT-3.5 Turbo models newer than `gpt-3.5-turbo-1106`. Setting Type to ResponseFormat.JsonObject enables JSON mode, which guarantees the message the model generates is valid JSON.")
    public var response_format:OpenAiResponseFormat?

    /**
    * This feature is in Beta. If specified, our system will make a best effort to sample deterministically, such that repeated requests with the same seed and parameters should return the same result. Determinism is not guaranteed, and you should refer to the system_fingerprint response parameter to monitor changes in the backend.
    */
    // @DataMember(Name="seed")
    // @ApiMember(Description="This feature is in Beta. If specified, our system will make a best effort to sample deterministically, such that repeated requests with the same seed and parameters should return the same result. Determinism is not guaranteed, and you should refer to the system_fingerprint response parameter to monitor changes in the backend.")
    public var seed:Int?

    /**
    * Up to 4 sequences where the API will stop generating further tokens.
    */
    // @DataMember(Name="stop")
    // @ApiMember(Description="Up to 4 sequences where the API will stop generating further tokens.")
    public var stop:[String]?

    /**
    * If set, partial message deltas will be sent, like in ChatGPT. Tokens will be sent as data-only server-sent events as they become available, with the stream terminated by a `data: [DONE]` message.
    */
    // @DataMember(Name="stream")
    // @ApiMember(Description="If set, partial message deltas will be sent, like in ChatGPT. Tokens will be sent as data-only server-sent events as they become available, with the stream terminated by a `data: [DONE]` message.")
    public var stream:Bool?

    /**
    * What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    */
    // @DataMember(Name="temperature")
    // @ApiMember(Description="What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.")
    public var temperature:Double?

    /**
    * An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    */
    // @DataMember(Name="top_p")
    // @ApiMember(Description="An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.")
    public var top_p:Double?

    /**
    * A list of tools the model may call. Currently, only functions are supported as a tool. Use this to provide a list of functions the model may generate JSON inputs for. A max of 128 functions are supported.
    */
    // @DataMember(Name="tools")
    // @ApiMember(Description="A list of tools the model may call. Currently, only functions are supported as a tool. Use this to provide a list of functions the model may generate JSON inputs for. A max of 128 functions are supported.")
    public var tools:[OpenAiTools]?

    /**
    * A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    */
    // @DataMember(Name="user")
    // @ApiMember(Description="A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.")
    public var user:String?

    required public init(){}
}

public class TextOutput : Codable
{
    /**
    * The generated text
    */
    // @ApiMember(Description="The generated text")
    public var text:String?

    required public init(){}
}

public class Choice : Codable
{
    /**
    * The reason the model stopped generating tokens. This will be stop if the model hit a natural stop point or a provided stop sequence, length if the maximum number of tokens specified in the request was reached, content_filter if content was omitted due to a flag from our content filters, tool_calls if the model called a tool
    */
    // @DataMember(Name="finish_reason")
    // @ApiMember(Description="The reason the model stopped generating tokens. This will be stop if the model hit a natural stop point or a provided stop sequence, length if the maximum number of tokens specified in the request was reached, content_filter if content was omitted due to a flag from our content filters, tool_calls if the model called a tool")
    public var finish_reason:String?

    /**
    * The index of the choice in the list of choices.
    */
    // @DataMember(Name="index")
    // @ApiMember(Description="The index of the choice in the list of choices.")
    public var index:Int?

    /**
    * A chat completion message generated by the model.
    */
    // @DataMember(Name="message")
    // @ApiMember(Description="A chat completion message generated by the model.")
    public var message:ChoiceMessage?

    required public init(){}
}

/**
* Usage statistics for the completion request.
*/
// @Api(Description="Usage statistics for the completion request.")
// @DataContract
public class OpenAiUsage : Codable
{
    /**
    * Number of tokens in the generated completion.
    */
    // @DataMember(Name="completion_tokens")
    // @ApiMember(Description="Number of tokens in the generated completion.")
    public var completion_tokens:Int?

    /**
    * Number of tokens in the prompt.
    */
    // @DataMember(Name="prompt_tokens")
    // @ApiMember(Description="Number of tokens in the prompt.")
    public var prompt_tokens:Int?

    /**
    * Total number of tokens used in the request (prompt + completion).
    */
    // @DataMember(Name="total_tokens")
    // @ApiMember(Description="Total number of tokens used in the request (prompt + completion).")
    public var total_tokens:Int?

    required public init(){}
}

/**
* The tool calls generated by the model, such as function calls.
*/
// @Api(Description="The tool calls generated by the model, such as function calls.")
// @DataContract
public class ToolCall : Codable
{
    /**
    * The ID of the tool call.
    */
    // @DataMember(Name="id")
    // @ApiMember(Description="The ID of the tool call.")
    public var id:String?

    /**
    * The type of the tool. Currently, only `function` is supported.
    */
    // @DataMember(Name="type")
    // @ApiMember(Description="The type of the tool. Currently, only `function` is supported.")
    public var type:String?

    /**
    * The function that the model called.
    */
    // @DataMember(Name="function")
    // @ApiMember(Description="The function that the model called.")
    public var function:String?

    required public init(){}
}

public enum ResponseFormat : String, Codable
{
    case Text
    case JsonObject
}

public enum OpenAiToolType : String, Codable
{
    case Function
}

// @DataContract
public class ChoiceMessage : Codable
{
    /**
    * The contents of the message.
    */
    // @DataMember(Name="content")
    // @ApiMember(Description="The contents of the message.")
    public var content:String?

    /**
    * The tool calls generated by the model, such as function calls.
    */
    // @DataMember(Name="tool_calls")
    // @ApiMember(Description="The tool calls generated by the model, such as function calls.")
    public var tool_calls:[ToolCall]?

    /**
    * The role of the author of this message.
    */
    // @DataMember(Name="role")
    // @ApiMember(Description="The role of the author of this message.")
    public var role:String?

    required public init(){}
}


